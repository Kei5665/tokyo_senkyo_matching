class User < ApplicationRecord
  has_many: :user_parties
  has_many: :user_questions
end
