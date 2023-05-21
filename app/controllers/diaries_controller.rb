class DiariesController < ApplicationController
  before_action :set_diary, only: [:show, :edit, :update]
  before_action :check_editable, only: [:edit, :update]


  def index
    @diary = Diary.today_for(current_user)
    if @diary
      redirect_to @diary
    else
      @diary = Diary.new
    end
  end
  

  def show
    if @diary.created_at.to_date != Date.today
      redirect_to diaries_path
    end
  end

  def create
    @diary = Diary.new(diary_params)
    if @diary.save
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
    params.require(:diary).permit(:title, :content, images: []).merge(user_id: current_user.id)
  end  

  def check_editable
    if @diary.created_at.to_date != Date.today
      redirect_to @diary, alert: "過去の日記は編集できません"
    end
  end
end
