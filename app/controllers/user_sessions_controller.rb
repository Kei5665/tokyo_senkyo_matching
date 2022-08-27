class UserSessionsController < ApplicationController
  def new
  end

  def guest_login
    redirect_to root_path, alert: 'すでにログインしています' if current_user # ログインしてる場合はユーザーを作成しない

    random_value = SecureRandom.hex
    user = User.create!(name: random_value, email: "test_#{random_value}@example.com")
    auto_login(user)
    redirect_to answers_path, notice: 'スタート！'
  end
end
