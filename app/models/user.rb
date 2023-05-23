class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, :nickname, :birthday, presence: true

  has_many :values
  has_many :habits
  has_many :goods
  has_many :diaries
  has_many :famous_quotes
  has_many :experiences
  has_many :reflections
  has_many :life_logs
  has_many :events
  has_many :essentials
  has_many :userinquiries

  enum confirmation_status: {
    confirmed: 0,
    unconfirmed: 1,
  }

  before_create :set_email_confirmation
  before_create :send_email_confirmation

  def set_email_confirmation
    self.confirmation_token = SecureRandom.urlsafe_base64(47)
    self.expiration_date = Time.zone.now + Constants::EMAIL_CONFIRMATION_LIMIT
  end

  def send_email_confirmation
    UserMailer.send_email_confirmation(self).deliver_later
  end

  def expired?
    expiration_date.present? ? expiration_date < Time.zone.now : false
  end

  def activate
    status = User.confirmation_statuses[:confirmed]
    update!(
      confirmation_status: status,
      confirmation_token: nil,
      expiration_date: nil,
    )
  end
end
