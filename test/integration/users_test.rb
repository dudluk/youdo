require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest
  test 'creating user with correct data' do
    get signup_path
    assert_template 'users/new'
    post users_path, user: {name: 'Name', email: 'user.name@gmail.com', username: 'username', password: 'password1234' }
    assert_not_nil session[:user_id]
    follow_redirect!
    assert_template 'users/show'
  end

  test 'creating user with incorrect data' do
    get signup_path
    assert_template 'users/new'
    post users_path, user: {name: 'Name', email: '', username: 'username', password: 'asd' }
    assert_nil session[:user_id]
    assert_template 'users/new'
  end

  test 'creating user with duplicated username' do
    login = 'username'
    password = 'password1234'
    user = User.new(name: 'User1', email: 'user.name@gmail.com', username: login, password: password)
    user.save

    get signup_path
    assert_template 'users/new'
    post users_path, user: {name: 'Other user', email: 'asd@gmail.com', username: login, password: password }
    assert_template 'users/new'
  end

end
