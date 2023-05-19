class Habit < ApplicationRecord
  validates :item, presence: true
  belongs_to :user

  def self.reset_checks
    all.each do |habit|
      habit.update!(check: false)
    end
  end
end
