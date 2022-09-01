class UserSessionsController < ApplicationController
  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
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
    auto_login(user)
    # ユーザーと全政党の紐付け
    user.create_party_relation

    redirect_to question_path(first_question), notice: 'スタート！'
  end
<<<<<<< HEAD

  private

    def login_as(user)
      session[:user_id] = user.id
      @current_user = user
    end
=======
>>>>>>> develop
end
