class UserSessionsController < ApplicationController
  def new
  end

  def guest_login
    first_question = Question.first

    redirect_to root_path, alert: 'すでにログインしています'

    random_value = SecureRandom.hex
    user = User.create!(name: random_value, email: "test_#{random_value}@example.com")
    login(user)

    redirect_to question_path(first_question), notice: 'スタート！'
  end

  private

  def login(user)
    session[:user_id] = user.id.to_s
    @current_user = user
  end
end
