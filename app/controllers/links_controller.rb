class LinksController < ApplicationController
  
  include HashtagsHelper
  include TextHelper
  include EmojiParser
    
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  
  # GET /links
  # GET /links.json
  def index
    @links = Link.paginate(:page => params[:page], :per_page => 10)
    case 
      when params[:search]
        @links = @links.search(params[:search])
        case
          when params[:sortDate]
            case params[:sortDate]
              when "asc"
                @links= @links.all.order('created_at ASC')
                @sd = true;
                @sn = false;
                @sv = false;
              when "desc"
                @links= @links.all.order('created_at DESC')
                @sd = false;
            end
          when params[:sortName]
            case params[:sortName]
              when "asc"
                @links= @links.order('title ASC')
                @sn = true;
                @sd = false;
                @sv = false;
              when "desc"
                @links= @links.order('title DESC')
                @sn = false;
            end
          when params[:sortVote]
            case params[:sortVote]
              when "desc"
                @links= @links.order('((cached_votes_up + 1.9208) / '+
                '(cached_votes_up + cached_votes_down) - 1.96 * '+
                '((cached_votes_up * cached_votes_down) / '+
                '(cached_votes_up + cached_votes_down) + 0.9604) / '+
                '(cached_votes_up + cached_votes_down)) / '+
                '(1 + 3.8416 / (cached_votes_up + cached_votes_down))  DESC')
                @sv = true;
                @sd = false;
                @sn = false;
              when "asc"
                @links= @links.order('((cached_votes_up + 1.9208) / '+
                '(cached_votes_up + cached_votes_down) - 1.96 * '+
                '((cached_votes_up * cached_votes_down) / '+
                '(cached_votes_up + cached_votes_down) + 0.9604) / '+
                '(cached_votes_up + cached_votes_down)) / '+
                '(1 + 3.8416 / (cached_votes_up + cached_votes_down))  ASC')
                @sv = false;
            end
          else
            @links= @links.all.order('created_at DESC')
        end
    else
      @links= @links.all.order('created_at DESC')
    end
  end

  # GET /links/1
  # GET /links/1.json
  def show
    if @comments.count === 0 || @comments.count >= 5
      @jakikom = 'komentarzy'
    elsif @comments.count === 1
      @jakikom = 'komentarz'
    else
      @jakikom = 'komentarze'
    end
    respond_to do |format|
      format.html
      format.js
    end
    if current_user
      u = User.find(current_user.id)
      if u.has_role? :admin
        @crud = true
      elsif @link.user === u
        @crud = true
      else
        @crud = false
      end
    else
      @crud = false
    end
    case
      when params[:sortDate]
        case params[:sortDate]
          when "desc"
            @comments = @comments.order('created_at DESC')
            @sd = true;
          when "asc"
            @comments = @comments.order('created_at ASC')
            @sd = false;
        end
    end
  end

  # GET /links/new
  def new
    @blokadaURL = false
    @link = current_user.links.build
  end

  # GET /links/1/edit
  def edit
    @blokadaURL = true
    @link.description = tokenize(@link.description || "")
    @link.description = returnHashtags(@link.description)
    @link.description = returnBIUS(@link.description)
    @link.description = returnEnter(@link.description)
  end

  # POST /links
  # POST /links.json
  def create
    @link = current_user.links.build(link_params)
    @link.description = detokenize(@link.description)
    @link.description = linkify_hashtags(@link.description)
    @link.description = convertBIUS(@link.description)
    @link.description = convertEnter(@link.description)
    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: 'Link został pomyślnie dodany.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    @lp = link_params
    @lp[:description] = detokenize(@lp[:description])
    @lp[:description] = linkify_hashtags(@lp[:description])
    @lp[:description] = convertBIUS(@lp[:description])
    @lp[:description]  = convertEnter(@lp[:description])
    respond_to do |format|
      if @link.update(@lp)
        format.html { redirect_to @link, notice: 'Dane zostały pomyślnie edytowane.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    destroy_hashtaggables(@comments.pluck('id'), 'Comment')
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link został pomyślnie usunięty.' }
      format.json { head :no_content }
    end
  end
  
  def upvote
    @link = Link.find(params[:id])
    @link.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @link = Link.find(params[:id])
    @link.downvote_from current_user
    redirect_to :back
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
      @comments = @link.comments.paginate(page: params[:page], per_page: 10)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:title, :url, :description)
    end
end