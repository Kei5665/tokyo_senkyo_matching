class QuestionsController < ApplicationController
  def show
    @question =Question.find(params[:id])
  end

  def answer
    # user = current_user
    user = User.find(1)
    @user_question = user.user_questions.find_by(question_id: params[:id])
    result = params[:result]

    # ユーザのresultを更新する
    @user_question.update_result(result)

    # 賛成/反対の意見を持つ政党リストを取得する


    # user_partiesテーブルのpointを計算する
    calculate_point(result)

    # next_questionへ遷移する
    next_page(@user_question)
  end

  private

  def calculate_point(result)
  end

  def next_page(user_question)
    if user_question.next?
      @next_question = user_question.next
      redirect_to question_path(@next_question)
    else
      redirect_to 結果ページ_path
    end
  end
end
