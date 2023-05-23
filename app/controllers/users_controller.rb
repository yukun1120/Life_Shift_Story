class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: '登録したメールアドレスに確認メールを送信しました。'
    else
      flash[:alert] = 'ユーザー登録ができませんでした。'
      render :new
    end
  end

  def edit
    
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def confirm_email
    if @user = User.find_by(confirmation_token: params[:token])
      unless @user.expired?
        @user.activate
      end
    end
  end

  private

  def user_params

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
