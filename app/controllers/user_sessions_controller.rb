class UserSessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user
      login_as(user)
      redirect_to rails_admin_path
    else
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

  def guest_login
    first_question = Question.first

    random_value = SecureRandom.hex
    # email uniqueness validationが設定したので、ゲストログインは必須としない
    user = User.create!(name: random_value, role: 0)
    login_as(user)
    # ユーザーと全政党の紐付け
    user.party_relation

    # ユーザーと全部の質問の紐付け
    user.question_relation

    redirect_to question_path(first_question), notice: 'スタート！'
  end

  private

  def login_as(user)
    session[:user_id] = user.id
    @current_user = user
  end
end
