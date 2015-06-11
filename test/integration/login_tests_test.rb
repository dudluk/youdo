require 'test_helper'
include ApplicationHelper

class LoginTestsTest < ActionDispatch::IntegrationTest
  test 'invalid login data test' do
    get login_path
    assert_template 'login/view'
    post login_path, session: { username: 'invalid', password: 'invalid'}
    assert_template 'login/view'
    assert flash[:invalid_login_data]
    assert_nil current_user
  end

  test 'missing login data test' do
    get login_path
    post login_path
    assert_template 'login/view'
  end

  test 'correct login data test' do
    login = 'username'
    password = 'password1234'

    user = User.new(name: 'User1', email: 'user.name@gmail.com', username: login, password: password)
    user.save

    get login_path
    assert_template 'login/view'
    post login_path, session: { username: login, password: password}
    assert_redirected_to user
    assert_not_nil current_user
  end
end
