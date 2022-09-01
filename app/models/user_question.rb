class UserQuestion < ApplicationRecord
  belongs_to :user
  belongs_to :question

  # ユーザー意見：超賛成、賛成、反対、無回答
  enum :result, { great: 0, good: 1, bad: 2, pending: 3 }

  # ユーザ意見が超賛成か賛成の場合
  def result_positive?
    self.great? || self.good?
  end

  # ユーザ意見が反対の場合
  def result_negative?
    self.bad?
  end

  # ユーザ意見が政党と一致する場合
  def agree_with_party?(party_question)
    both_agree?(party_question) || both_disagree?(party_question)
  end

  # ユーザ意見が政党と不一致する場合
  def disagree_with_party?(party_question)
    user_positive_but_party_disagree?(party_question) || user_negative_but_party_agree?(party_question)
  end

  # 議題に対して、ユーザも政党も賛成する場合
  def both_agree?(party_question)
    result_positive? && party_question.agree?
  end

  # 議題に対して、ユーザも政党も反対する場合
  def both_disagree?(party_question)
    result_negative? && party_question.disagree?
  end

  # 議題に対して、ユーザが賛成で、政党が反対する場合
  def user_positive_but_party_disagree?(party_question)
    result_positive? && party_question.disagree?
  end

  # 議題に対して、ユーザが反対で、政党が賛成する場合
  def user_negative_but_party_agree?(party_question)
    result_negative? && party_question.agree?
  end
end
