class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :nickname, :birthday, presence: true

  has_many :values
  has_many :habits
  has_many :goods
  has_many :diaries
  has_many :famous_quotes
  has_many :experiences
  has_many :reflections

end
