require 'test_helper'

class CommentTest < ActiveSupport::TestCase
 setup do
    @komentarz1 = comments(:one)
    @komentarz2 = comments(:two)
  end
  
  test "should validate comment" do 
    assert @komentarz1.valid?
  end

  test "should fail without link_id" do
    refute @komentarz2.valid?, 'saved comment to nothing'
    assert_not_nil @komentarz2.errors[:link_id]
  end
  
  test "should fail without comment text" do
    @komentarz1.body = nil
    refute @komentarz1.valid?, 'saved empty comment'
    assert_not_nil @komentarz1.errors[:body]
  end
end
