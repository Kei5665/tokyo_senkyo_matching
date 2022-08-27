class UserQuestion < ApplicationRecord
  belongs_to :user
  belongs_to :question

  enum :result, { great: 0, good: 1, bad: 2, pending: 3 }

  def next
    # user_questions = UserQuestion.where(user_id: current_user.id)
    user_questions = UserQuestion.where(user_id: 1)
    user_questions.where("question_id > ?", question_id).first
  end

  def next?
    self.next.present?
  end

  def update_result(result)
    case result
    when "超賛成"
      self.great!
    when "賛成"
      self.good!
    when "反対"
      self.bad!
    when "無回答"
      self.pending!
    end
  end
end
