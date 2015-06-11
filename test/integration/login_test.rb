require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest
  test 'invalid login data' do
    get login_path
    assert_template 'login/view'
    post login_path, session: { username: 'invalid', password: 'invalid'}
    assert_template 'login/view'
    assert flash[:invalid_login_data]
    assert_nil session[:user_id]
  end

  test 'missing login data' do
    get login_path
    post login_path
    assert_template 'login/view'
  end

  test 'correct login data' do
    login = 'username'
    password = 'password1234'

    user = User.new(name: 'User1', email: 'user.name@gmail.com', username: login, password: password)
    user.save

    get login_path
    assert_template 'login/view'
    post login_path, session: { username: login, password: password}
    assert_not_nil session[:user_id]
  end

  test 'log in and log out' do
    login = 'username'
    password = 'password1234'

    user = User.new(name: 'User1', email: 'user.name@gmail.com', username: login, password: password)
    user.save

    get login_path
    assert_template 'login/view'
    post login_path, session: { username: login, password: password}
    assert_redirected_to user
    assert_not_nil session[:user_id]

    delete logout_path
    assert_redirected_to root_path
    assert_nil session[:user_id]
  end
end
