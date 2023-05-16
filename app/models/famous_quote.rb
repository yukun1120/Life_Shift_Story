class FamousQuote < ApplicationRecord
  validates :phrase, presence: true
  belongs_to :user

  def self.update_random_quote
    update_all(displayed: false)
    random_quote = order("RAND()").first
    random_quote.update!(displayed: true) if random_quote.present?
  end

end
