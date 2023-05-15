class DiariesController < ApplicationController
  before_action :set_diary, only: [:show, :edit, :update]

  def index
    @diary = Diary.today_for(current_user)
  
    if @diary
      redirect_to @diary
    else
      @diary = Diary.new
    end
  end
  

  def show
  end

  def create
    @diary = Diary.new(diary_params)
    if @diary.valid?
      @diary.save
      redirect_to @diary
    else
      render :index
    end
  end

  def edit
  end

  def update
    if @diary.update(diary_params)
      redirect_to @diary
    else
      render :edit
    end
  end

  private

  def set_diary
    @diary = Diary.find(params[:id])
  end

  def diary_params
    params.require(:diary).permit(:title, :content).merge(user_id: current_user.id)
  end
end
