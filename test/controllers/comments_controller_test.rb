require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment = comments(:one)
  end

  test "should get index" do
    skip()
    get comments
    assert_response :success
  end

  test "should get new" do
    skip()
    get new_comment_url
    assert_response :success
  end

  test "should create comment" do
    skip()
    assert_difference('Comment.count') do
      post comments_url, params: { comment: { body: @comment.body, link_id: @comment.link_id, user_id: @comment.user_id } }
    end

    assert_redirected_to comment_url(Comment.last)
  end

  test "should show comment" do
    skip()
    get comment_url(@comment)
    assert_response :success
  end

  test "should get edit" do
    skip()
    get edit_comment_url(@comment)
    assert_response :success
  end

  test "should update comment" do
    skip()
    patch comment_url(@comment), params: { comment: { body: @comment.body, link_id: @comment.link_id, user_id: @comment.user_id } }
    assert_redirected_to comment_url(@comment)
  end

  test "should destroy comment" do
    skip()
    assert_difference('Comment.count', -1) do
      delete comment_url(@comment)
    end

    assert_redirected_to comments_url
  end
end
