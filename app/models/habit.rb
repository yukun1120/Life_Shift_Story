class Habit < ApplicationRecord
  validates :item, presence: true
  belongs_to :user
end
