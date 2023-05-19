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
    if params[:habit][:check].nil?  # check data is not sent
      if @habit.update(item_params)
        redirect_to habits_path
      else
        render :edit
      end
    elsif params[:habit][:item].nil? # item data is not sent
      if @habit.update(check_params)
        render json: @habit, status: :ok
      else
        render json: @habit.errors, status: :unprocessable_entity
      end
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
    params.require(:habit).permit(:item, :check).merge(user_id: current_user.id)
  end
  
  def item_params
    params.require(:habit).permit(:item).merge(user_id: current_user.id)
  end

  def check_params
    params.require(:habit).permit(:check)
  end

end
