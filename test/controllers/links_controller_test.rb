require 'test_helper'

class LinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @link = links(:one)
  end

  test "should get index" do
    skip()
    get '/links/1'
    assert_response :success
    assert_not_nil assigns(:links)
  end

  test "should get new" do
    skip()
    get new_link_url
    assert_response :success
  end

  test "should create link" do
    skip()
    assert_difference('Link.count') do
      post links_url, params: { link: { title: @link.title, url: @link.url } }
    end

    assert_redirected_to link_url(Link.last)
  end

  test "should show link" do
    skip()
    get link_url(@link)
    assert_response :success
  end

  test "should get edit" do
    skip()
    get edit_link_url(@link)
    assert_response :success
  end

  test "should update link" do
    skip()
    patch link_url(@link), params: { link: { title: @link.title, url: @link.url } }
    assert_redirected_to link_url(@link)
  end

  test "should destroy link" do
    skip()
    assert_difference('Link.count', -1) do
      delete link_url(@link)
    end

    assert_redirected_to links_url
  end
end
