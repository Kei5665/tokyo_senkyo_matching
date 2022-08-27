class PartyQuestion < ApplicationRecord
  belongs_to :question
  belongs_to :party
end
