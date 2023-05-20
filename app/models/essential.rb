class Essential < ApplicationRecord
  belongs_to :user

  validates :title, :content, :start_time, :end_time, presence: true
end
