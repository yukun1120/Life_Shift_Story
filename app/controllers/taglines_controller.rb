class TaglinesController < ApplicationController
  before_action :set_tagline, only: [:edit, :update, :destroy]

#ここから再開

  def index
    @taglines = current_user.taglines
  end

  def new
    @tagline = Tagline.new
  end

  def create
    @tagline = Tagline.new(tagline_params)
    if @tagline.valid?
      @tagline.save
      redirect_to taglines_path
    else
      
      render :new

    end
  end
  def show
    @tagline = Tagline.find(params[:id])
  end

  def edit
  end

  def update
    if @tagline.update(tagline_params)
      redirect_to taglines_path
    else
      render :edit
    end
  end

  def destroy
    @tagline.destroy
    redirect_to taglines_path
  end

  private
  def set_tagline
    @tagline = Tagline.find(params[:id])
  end

  def tagline_params
    params.require(:tagline).permit(:title, :content).merge(user_id: current_user.id)
  end
end
