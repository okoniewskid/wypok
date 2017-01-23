require 'rails_helper'

RSpec.describe "post_comments/edit", type: :view do
  before(:each) do
    @post_comment = assign(:post_comment, PostComment.create!(
      :name => "MyString",
      :body => "MyText",
      :post => nil
    ))
  end

  it "renders the edit post_comment form" do
    render

    assert_select "form[action=?][method=?]", post_comment_path(@post_comment), "post" do

      assert_select "input#post_comment_name[name=?]", "post_comment[name]"

      assert_select "textarea#post_comment_body[name=?]", "post_comment[body]"

      assert_select "input#post_comment_post_id[name=?]", "post_comment[post_id]"
    end
  end
end
