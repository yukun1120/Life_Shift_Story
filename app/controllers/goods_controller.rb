class GoodsController < ApplicationController
  def index
    @goods = current_user.goods
  end

  def new
    @good = Good.new
  end

  def create
    @good = Value.new(good_params)
    if @good.valid?
      @good.save
      redirect_to goods_path
    else
      render :new
    end
  end

  private
  def good_params
    params.require(:good).permit(:good_thing).merge(user_id: current_user.id)
  end
end
