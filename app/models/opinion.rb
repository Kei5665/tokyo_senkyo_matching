class Opinion < ApplicationRecord
  validates :category, presence: true
end
