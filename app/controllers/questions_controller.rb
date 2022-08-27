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
    # result更新にエラーが出たので、後で対応
    # case result
    #   when "超賛成"
    #     user_question.result.great!
    #   when "賛成"
    #     user_question.result.good!
    #   when "反対"
    #     user_question.result.bad!
    # end

    # 賛成/反対の意見を持つ政党リストを取得する


    # user_partiesテーブルのpointを加算する
    count_point(result)

    # next_questionへ遷移する
    next_page(@user_question)
  end

  def count_point(result)
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
