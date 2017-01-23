require 'rails_helper'

RSpec.describe "post_comments/new", type: :view do
  before(:each) do
    assign(:post_comment, PostComment.new(
      :name => "MyString",
      :body => "MyText",
      :post => nil
    ))
  end

  it "renders new post_comment form" do
    render

    assert_select "form[action=?][method=?]", post_comments_path, "post" do

      assert_select "input#post_comment_name[name=?]", "post_comment[name]"

      assert_select "textarea#post_comment_body[name=?]", "post_comment[body]"

      assert_select "input#post_comment_post_id[name=?]", "post_comment[post_id]"
    end
  end
end
