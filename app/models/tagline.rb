class Tagline < ApplicationRecord
  belongs_to :user
  belongs_to :home
  validates :title, :content, presence: true

  def self.update_random_tagline_for_user(user)
    where(user: user).update_all(displayed: false)
    random_tagline = where(user: user).order("RAND()").first
    random_tagline.update!(displayed: true) if random_tagline.present?
  end
end
