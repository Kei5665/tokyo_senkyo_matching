class QuestionsController < ApplicationController
  def show
    @question =Question.find(params[:id])
  end

  def answer
    user = current_user
    user_question = user.user_questions.find_by(question_id: params[:id])
    result = params[:result]

    # ユーザのresultを更新する
    user_question.update_result(result)

    # ユーザーに紐づいた政党一覧を取得して
    # ユーザー意見と参照して各政党のpointを計算する
    user.user_parties.each do |user_party|
      user_party.calculate_point(user_question)
    end

    # next_questionへ遷移する
    next_page(user_question)
  end

  private

  # 次の質問が存在すれば、次の詳細ページへ遷移
  # 次がなければ、結果ページへ遷移する
  def next_page(user_question)
    if user_question.next?
      next_question = user_question.next
      redirect_to question_path(next_question)
    else
      redirect_to result_path
    end
  end
end
