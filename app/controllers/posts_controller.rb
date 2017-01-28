class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all.order('created_at DESC')
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    if @comments.count === 0 || @comments.count >= 5
      @jakiKom = 'komentarzy'
    elsif @comments.count === 1
      @jakiKom = 'komentarz'
    else
      @jakiKom = 'komentarze'
    end
    if current_user
      u = User.find(current_user.id)
      if u.has_role? :admin
        @crud = true
      elsif @post.user === u
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

  # GET /posts/new
  def new
    @post = current_user.posts.build
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Wpis został dodany.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Wpis został zmieniony.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Wpis został usunięty.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
      @comments = @post.post_comments.paginate(page: params[:page], per_page: 10)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
