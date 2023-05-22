class UserinquiriesController < ApplicationController
  def index
    @userinquiry = Userinquiry.new
  end

  def create
    @userinquiry = Userinquiry.new(userinquiry_params)
    if @userinquiry.save
      redirect_to homes_path
    else
      render :index
    end
  end

  private
  def userinquiry_params
    params.require(:userinquiry).permit(:title, :content).merge(user_id: current_user.id)
  end
end
