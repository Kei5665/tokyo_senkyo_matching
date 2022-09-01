class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show answer]

  def show; end

  def answer
    user_question = current_user.user_questions.find_by(question_id: params[:id])
    result = params[:result]

    # ユーザのresultを更新する
    user_question.update_result(result)

    # ユーザーに紐づいた政党一覧を取得して
    # ユーザー意見と参照して各政党のpointを計算する
    current_user.user_parties.each do |user_party|
      user_party.calculate_point(user_question)
    end

    # 次のquestion詳細ページへ遷移する
    next_page(@question)
  end

  private

  def set_question
    @question =Question.find(params[:id])
  end

  # 次の質問が存在すれば、次の詳細ページへ遷移
  # 次がなければ、結果ページへ遷移する
  def next_page(question)
    if question.next_question.present?
      redirect_to question_path(question.next_question)
    else
      redirect_to result_path
    end
  end
end
