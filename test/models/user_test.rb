require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'Should user be valid when email and name is not empty' do
    user = User.new(name: 'Lukasz', email: 'lukasz.dudek@gmail.com')

    assert user.valid?
  end

  test 'Should user not be valid when name is missing' do
    user = User.new(name: '', email: 'lukasz.dudek@gmail.com')

    assert_not user.valid?
  end

  test 'Should user not be valid when email is missing' do
    user = User.new(name: 'Lukasz', email: '')

    assert_not user.valid?
  end

end
