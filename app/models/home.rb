class Home < ApplicationRecord
  has_many :famous_quotes
  has_many :taglines
end
