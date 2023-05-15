class Diary < ApplicationRecord
  validates :title, :content, presence: true

  belongs_to :user

  def self.today_for(user)
    where("created_at >= ?", Time.zone.now.beginning_of_day)
      .where(user: user)
      .first
  end
end
