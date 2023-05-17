class Value < ApplicationRecord
  validates :title, :content, presence: true
  belongs_to :user
  has_one :reflection, dependent: :delete
end