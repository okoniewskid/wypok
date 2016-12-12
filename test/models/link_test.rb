require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  setup do
    @link1 = links(:one)
    @link2 = links(:two)
    @link3 = links(:three)
  end
  
  test "should validate link" do 
    assert @link1.valid?
  end
  
  test "should fail with invalid url" do
    refute @link2.valid?, 'saved link with invalid url'
    assert_not_nil @link2.errors[:url]
  end
  
  test "should fail without title" do
    refute @link3.valid?, 'saved link without title'
    assert_not_nil @link3.errors[:url]
  end
end
