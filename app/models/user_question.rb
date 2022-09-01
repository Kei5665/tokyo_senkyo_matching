class UserQuestion < ApplicationRecord
  belongs_to :user
  belongs_to :question

  # ユーザー意見：超賛成、賛成、反対、無回答
  enum :result, { great: 0, good: 1, bad: 2, pending: 3 }
end
