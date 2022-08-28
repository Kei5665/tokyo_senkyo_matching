class UserSessionsController < ApplicationController
  def new
  end

  def guest_login
    first_question = Question.first

    random_value = SecureRandom.hex
    user = User.create!(name: random_value, email: "test_#{random_value}@example.com")
    login(user)

    # ユーザーと全政党の紐付け
    user.party_relation

    # ユーザーと全部の質問の紐付け
    user.question_relation

    redirect_to question_path(first_question), notice: 'スタート！'
  end

  private

  def login(user)
    session[:user_id] = user.id
    @current_user = user
  end
end
