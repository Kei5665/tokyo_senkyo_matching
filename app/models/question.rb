class Question < ApplicationRecord
  validates :content, presence: true
  has_many :user_questions, dependent: :destroy
  has_many :party_questions, dependent: :destroy
end
