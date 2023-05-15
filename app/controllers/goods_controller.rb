class GoodsController < ApplicationController
  before_action :set_good, only: [:edit, :update, :destroy]

  def index
    @goods = current_user.goods.where(confirmed: false)
  end

  def new
    @good = Good.new
  end

  def create
    @good = Good.new(good_params)
    @good.confirmed = false
    if @good.valid?
      @good.save
      redirect_to goods_path
    else
      render :new
    end
  end
  

  def edit
    
  end

  def update
    if @good.update(good_params)
      redirect_to goods_path
    else
      render :edit
    end
  end

  def destroy
    @good.destroy
    redirect_to goods_path
  end

  private
  def good_params
    params.require(:good).permit(:good_thing).merge(user_id: current_user.id)
  end

  def set_good
    @good = Good.find(params[:id])
  end
end
