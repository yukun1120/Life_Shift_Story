class Diary < ApplicationRecord
  validates :title, :content, presence: true, unless: :was_attached?

  belongs_to :user
  has_many_attached :images


  def self.today_for(user)
    where("created_at >= ?", Time.zone.now.beginning_of_day)
      .where(user: user)
      .first
  end

  def was_attached?
    self.images.attached?
  end
end
