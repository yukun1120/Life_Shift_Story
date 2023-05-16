class Experience < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :genre

  belongs_to :user

  validates :title, :content, :actionplan, presence: true
  validates :genre_id, numericality: { other_than: 1 } 
end
