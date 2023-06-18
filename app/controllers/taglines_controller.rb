class TaglinesController < ApplicationController
  def index
    @tagline = Tagline.new
  end

  def create
    Tagline.create(tagline_params)
  end

  def edit
    @tagline = Tagline.find(params[:id])
  end

  def update
    if @tagline.update(tagline_params)
      redirect_to @tagline
    else
      render :edit
    end
  end

  private
  def tagline_params
    params.require(:tagline).permit(:title, :content).merge(user_id: current_user.id)
  end
end
