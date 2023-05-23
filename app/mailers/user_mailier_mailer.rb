class UserMailierMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def send_email_confirmation(user)
    @user = user
    mail(to: @user.email, subject: 'メールアドレス認証のお願い')
  end

end
