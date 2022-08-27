class UserQuestion < ApplicationRecord
  belongs_to :user
  belongs_to :question

  enum :result, { great: 0, good: 1, bad: 2, pending: 3 }
end
