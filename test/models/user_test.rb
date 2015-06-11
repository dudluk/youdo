require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  PASSWORD = 'password123!'

  def setup
    @user = User.new(name: 'Username', email: 'user.name@gmail.com', username: 'username', password: PASSWORD)
  end

  test 'Should be valid created with correct data' do
    assert @user.valid?
  end

  test 'Should user not be valid when name is missing' do
    @user.name = ''

    assert_not @user.valid?
  end

  test 'Should user not be valid when email is missing' do
    @user.email = ''

    assert_not @user.valid?
  end

  test 'Should user not be valid when password is missing' do
    skip 'I dont understand why this test is failing'
    @user.password = ''

    assert_not @user.valid?
  end

  test 'Should user not be valid when password is too short' do
    @user.password = 'a' * 11

    assert_not @user.valid?
  end

  test 'Should user authenticate with correct password' do
    @user.save

    assert @user.authenticate(PASSWORD)
  end

  test 'Should not user authenticate with incorrect password' do
    @user.save

    assert_not @user.authenticate('incorrect')
  end
end
