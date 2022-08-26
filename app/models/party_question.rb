class PartyQuestion < ApplicationRecord
  belongs_to :questions
  belongs_to :parties
  validates :opinion, presence: true
end
