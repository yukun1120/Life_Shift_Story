class Good < ApplicationRecord
  validates :good_thing, presence: true

  belongs_to :user
end
