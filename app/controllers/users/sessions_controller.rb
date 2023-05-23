# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user&.authenticate(params[:password])
      if user.confirmed?
        log_in(user)
        redirect_to root_path, notice: 'ログインしました。'
      else
        flash[:alert] = 'メールアドレス認証を行ってください。'
        render :new
      end
    else
      flash[:alert] = 'メールアドレスかパスワードが間違っています。'
      render :new
    end
  end

  def resend_email_confirmation
    user = User.find_by(email: params[:email].downcase)
    if user&.authenticate(params[:password])
      if user.save
        redirect_to root_path, notice: '登録されているメールアドレスに確認メールを送信しました。'
      else
        flash[:alert] = '確認メールの再送に失敗しました。'
        render :new
      end
    else
      flash[:alert] = 'メールアドレスかパスワードが間違っています。'
      render :new
    end
  end
end
