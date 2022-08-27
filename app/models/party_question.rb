class PartyQuestion < ApplicationRecord
  belongs_to :question
  belongs_to :party
  validates :opinion, presence: true

  has_many :opinions
end
