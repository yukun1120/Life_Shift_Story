class HabitsController < ApplicationController
  before_action :set_habit, only: [:edit, :update, :destroy]

  def index
    @habits = current_user.habits
  end

  def new
    @habit = Habit.new
  end

  def create
    @habit = Habit.new(habit_params)
    @habit.achieved = params[:habit][:achieved] # achievedの値を設定する
    @habit.check = params[:habit][:check] # checkの値を設定する
    if @habit.valid?
      @habit.save
      redirect_to habits_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @habit.achieved = params[:habit][:achieved] # achievedの値を設定する
    @habit.check = params[:habit][:check] # checkの値を設定する

    if @habit.update(habit_params)
      redirect_to habits_path
    else
      render :edit
    end
  end

  def destroy
    @habit.destroy
    redirect_to habits_path
  end

  def update_achievement_rate
    current_user.habits.each do |habit|
      habit.update(achieved: params[:achievement_rate])
    end
    head :ok
  end

  def update_checkbox_state
    habit = Habit.find_by(id: params[:habit_id], user_id: params[:user_id])
    if habit
      # check = ActiveRecord::Type::Boolean.new.cast(params[:check])
      check = params[:check] == 'true'
      habit.update(check: check)
      render json: { status: 'success', message: 'Updated checkbox state' }
    else
      render json: { status: 'error', message: 'Habit not found' }, status: 404
    end
  end
  
  
  private
  
  def set_habit
    @habit = Habit.find(params[:id])
  end
  
  def habit_params
    params.require(:habit).permit(:item).merge(user_id: current_user.id)
  end

end
