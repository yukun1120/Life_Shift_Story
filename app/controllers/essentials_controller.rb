class EssentialsController < ApplicationController
  def index
    @essentials = current_user.essentials
    @events = current_user.events
    @essential = Essential.new
    @day_essentials = current_user.essentials
    @week_essentials = []
    start_date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today
    7.times do |i|
      day_items = (current_user.essentials.where("DATE(start_time) = ?", start_date + i.days) +
                  current_user.events.where("DATE(start_time) = ?", start_date + i.days)).sort_by { |item| item.start_time }
      @week_essentials << day_items
    end

  end

  def new
    @essential = Essential.new
  end


  def create
    Essential.create(essential_parameter)
    redirect_to essentials_path
  end

  def destroy
    @essential = Essential.find(params[:id])
    @essential.destroy
    redirect_to essentials_path, notice:"削除しました"
  end

  def edit
    @essential = Essential.find(params[:id])
  end

  def update
    @essential = Essential.find(params[:id])
    if @essential.update(essential_parameter)
      redirect_to essentials_path, notice: "編集しました"
    else
      render 'edit'
    end
  end

  def fetch_schedule
    date = Date.parse(params[:date])
    day_items = (current_user.essentials.where("DATE(start_time) = ?", date) +
                current_user.events.where("DATE(start_time) = ?", date)).sort_by { |item| item.start_time }
    
    if day_items.empty?
      render json: { message: 'No events found for this date.' }, status: :not_found
    else
      render json: day_items.as_json(only: [:id, :title, :start_time, :end_time, :content]) # or use custom logic to convert your items to JSON
    end
  end

  
  

  private

  def essential_parameter
    params.require(:essential).permit(:title, :content, :start_time, :end_time).merge(user_id: current_user.id)
  end
end
