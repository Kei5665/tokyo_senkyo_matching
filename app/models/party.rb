class Party < ApplicationRecord
  validates :context, presence: true
end
