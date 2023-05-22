class Notion < ApplicationRecord
  validates :title, :content, presence: true
end
