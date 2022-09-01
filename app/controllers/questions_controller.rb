class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show answer]

  def show; end

  def answer
    # ユーザと質問を紐付けて、質問回答をDBに保存
    result = params[:result]
    current_user.save_result(@question, result)

    # ユーザー意見と参照して各政党のpointを計算する
    current_user.user_parties.calculate_point(@question, result)

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
