class FamousQuote < ApplicationRecord
  validates :phrase, presence: true
  belongs_to :user
  belongs_to :home
end
