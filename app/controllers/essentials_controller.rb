class EssentialsController < ApplicationController
  def index
    @essentials = current_user.essentials
    @essential = Essential.new
  end
  
  def new
    @essential = Essential.new
  end

  def show
    @essential = Essential.find(params[:id])
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
