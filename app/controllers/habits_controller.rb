class HabitsController < ApplicationController
  before_action :set_habit, only: [:edit, :update, :destroy]

  def index
    @habits = Habit.includes(:user)
  end

  def new
    @habit = Habit.new
  end

  def create
    @habit = Habit.new(habit_params)
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

  private

  def set_habit
    @habit = Habit.find(params[:id])
  end

  def habit_params
    params.require(:habit).permit(:item).merge(user_id: current_user.id)
  end
end
