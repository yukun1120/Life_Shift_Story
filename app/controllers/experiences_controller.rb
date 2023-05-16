class ExperiencesController < ApplicationController
  def index
    @experiences = current_user.experiences.order("genre_id DESC")
  end

  def new
    @experience = Experience.new
  end

  def create
    @experience = Experience.new(experience_params)
    if @experience.save
      redirect_to experiences_path

    else
      render :new
    end
  end

  def show
    @experience = Experience.find(params[:id])
  end

  def edit
    @experience = Experience.find(params[:id])
  end

  def update
    @experience = Experience.find(params[:id])
    if @experience.update(experience_params)
      redirect_to experience_path(experience.id)
    else
      render :edit
    end
  end

  def destroy
    @experience = Experience.find(params[:id])
    @experience.destroy
    redirect_to experiences_path
  end

  private
  def experience_params
    params.require(:experience).permit(:title, :content, :genre_id, :actionplan).merge(user_id: current_user.id)
  end
end
