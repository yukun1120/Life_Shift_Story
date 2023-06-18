class TaglinesController < ApplicationController
  def index
    @tagline = Tagline.new
  end

  def create
    Tagline.create(tagline_params)
  end

  private
  def tagline_params
    params.require(:tagline).permit(:title, :content).merge(user_id: current_user.id)
  end
end
