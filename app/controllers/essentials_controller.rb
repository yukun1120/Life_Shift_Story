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

  private

  def essential_parameter
    params.require(:essential).permit(:title, :content, :start_time, :end_time).merge(user_id: current_user.id)
  end
end
