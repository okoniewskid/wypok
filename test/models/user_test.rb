require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:valid_user)
  end
  
  test 'should validate user' do
    assert @user.valid?
  end
  
  test 'should be invalid without name' do
    @user.name = nil
    refute @user.valid?, 'saved user without a name!!'
    assert_not_nil @user.errors[:name]
  end
  
  test 'should be invalid without email' do
    @user.email = nil
    refute @user.valid?, 'saved user without email!!'
    assert_not_nil @user.errors[:email]
  end
end
