class PartyQuestion < ApplicationRecord
  belongs_to :question
  belongs_to :party

  # enum opinion: [ "賛成", "反対", "中立" ]
  enum :opinion, { agree: 0, disagree: 1, neutral: 2 }
end
