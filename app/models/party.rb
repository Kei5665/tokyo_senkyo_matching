class Party < ApplicationRecord
  validates :name, presence: true
  has_many :party_questions
end
