require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest
  SAMPLE_PASSWORD = 'password1234'

  test 'creating user with correct data' do
    get signup_path
    assert_template 'users/new'
    post users_path, user: {name: 'Name', email: 'user.name@gmail.com', username: 'username', password: SAMPLE_PASSWORD}
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
    login = 'sample_login'
    user = create_user(login)

    get signup_path
    assert_template 'users/new'
    post users_path, user: {name: 'Other user', email: 'asd@gmail.com', username: login, password: SAMPLE_PASSWORD }
    assert_template 'users/new'
  end

  test 'limiting access to user profile for not logged in users' do
    user = create_user('user')

    get user_path user.id
    assert_redirected_to root_path
  end

  test 'limiting access to other users profile' do
    username = 'user'
    user = create_user(username)
    otherUser = create_user('otherUser')

    post login_path, session: { username: username, password: SAMPLE_PASSWORD}

    get user_path otherUser.id
    assert_redirected_to root_path
  end

  private
  def create_user(username)
    user = User.new(name: 'User ' + username, email: username + '@gmail.com', username: username, password: SAMPLE_PASSWORD)
    user.save
    return user
  end
end
