class Reflection < ApplicationRecord
  validates :self_assessment, :action, presence: true

  belongs_to :user
  belongs_to :value
end
