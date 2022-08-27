class UserSessionsController < ApplicationController
  def new
  end

  def guest_login
    redirect_to root_path, alert: 'すでにログインしています'

    random_value = SecureRandom.hex
    user = User.create!(name: random_value, email: "test_#{random_value}@example.com")
    login(user)
    redirect_to answers_path, notice: 'スタート！'
  end

  private

  def login(user)
    session[:user_id] = user.id.to_s
    @current_user = user
  end
end
