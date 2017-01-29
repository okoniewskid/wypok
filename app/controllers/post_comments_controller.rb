class PostCommentsController < ApplicationController
  before_action :set_post_comment, only: [:show, :edit, :update, :destroy]
  
  include EmojiHelper
  include HashtagsHelper
  include TextHelper

  # POST /post_comments
  # POST /post_comments.json
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.post_comments.create(post_comment_params)
    @comment.body = emojify(@comment.body)
    @comment.body = linkify_hashtags(@comment.body)
    @comment.body = convertBIUS(@comment.body)
    @comment.body = convertEnter(@comment.body)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: 'Komentarz został dodany.' }
        format.json { render :show, status: :created, location: @post_comment }
      else
        format.html { render :new }
        format.json { render json: @post_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /post_comments/1
  # DELETE /post_comments/1.json
  def destroy
    @post = Post.find(params[:post_id])
    @post_comment.destroy
    respond_to do |format|
      format.html { redirect_to @post, notice: 'Komentarz został usunięty.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post_comment
      @post_comment = PostComment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_comment_params
      params.require(:post_comment).permit(:name, :body, :post_id)
    end
end
