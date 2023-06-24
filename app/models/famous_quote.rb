class FamousQuote < ApplicationRecord
  validates :phrase, presence: true
  belongs_to :user
  belongs_to :home

  def self.update_random_quote_for_user(user)
    where(user: user).update_all(displayed: false)
    random_quote = where(user: user).order("RAND()").first
    random_quote.update!(displayed: true) if random_quote.present?
  end
end
