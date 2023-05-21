class FamousQuote < ApplicationRecord
  validates :phrase, presence: true
  belongs_to :user

  def self.update_random_quote_for_user(user)
    where(user: user).update_all(displayed: false)
    random_quote = where(user: user).order("RANDOM()").first
    random_quote.update!(displayed: true) if random_quote.present?
  end
end
