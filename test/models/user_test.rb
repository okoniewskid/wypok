require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:valid_user)
  end
  
  test 'is user valid' do
    assert @user.valid?
  end
  
  test 'invalid without name' do
    @user.name = nil
    refute @user.valid?, 'saved user without a name!!'
    assert_not_nil @user.errors[:name]
  end
  
  test 'invalid without email' do
    @user.email = nil
    refute @user.valid?, 'saved user without email!!'
    assert_not_nil @user.errors[:email]
  end
end
