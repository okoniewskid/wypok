class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  # GET /links
  # GET /links.json
  def index
    @links = Link.paginate(:page => params[:page], :per_page => 10)
    if params[:search]
       @links = @links.search(params[:search])
    elsif params[:sortDate]
      if params[:sortDate] == "desc"
        @links= @links.all.order('created_at DESC')
        @sd = true;
      else
        @links= @links.all.order('created_at ASC')
        @sd = false;
      end
    elsif params[:sortName]
      if params[:sortName] == "desc"
        @links= @links.order('title DESC')
        @sn = true;
      else
        @links= @links.order('title ASC')
        @sn = false;
      end
    elsif params[:sortVote]
      if params[:sortVote] == "desc"
        @links= @links.sort { |x,y| y <=> x  }
        @sv = true;
      else
        @links= @links.sort { |x,y| x <=> y }
        @sv = false;
      end
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
  end

  # GET /links/new
  def new
    @blokadaURL = false
    @link = current_user.links.build
  end

  # GET /links/1/edit
  def edit
    @blokadaURL = true
  end

  # POST /links
  # POST /links.json
  def create
    @link = current_user.links.build(link_params)

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
    respond_to do |format|
      if @link.update(link_params)
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
      params.require(:link).permit(:title, :url)
    end
    
end