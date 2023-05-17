class Value < ApplicationRecord
  validates :title, :content, presence: true
  belongs_to :user
  has_many :reflections, dependent: :delete_all
end