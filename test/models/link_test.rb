require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  setup do
    @link = links(:one)
    @link2 = links(:two)
    @link3 = links(:three)
    
    @links = [@link1, @link2, @link3]
  end
  
  test "should validate link" do 
    assert @link.valid?
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
