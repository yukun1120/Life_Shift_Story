class TaglinesController < ApplicationController
  def index
    @tagline = Tagline.new
  end

  def create
    @tagline = Tagline.create(tagline_params)
    if @tagline.save
      redirect_to homes_path
    else
      render :index
    end
  end

  private
  def tagline_params
    params.require(:tagline).permit(:title, :content).merge(user_id: current_user.id)
  end
end
