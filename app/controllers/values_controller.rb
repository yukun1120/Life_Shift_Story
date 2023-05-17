class ValuesController < ApplicationController
  def index
    @values = current_user.values
  end
  def new
    @value = Value.new
  end
  def create
    @value = Value.new(value_params)
    if @value.valid?
      @value.save
      redirect_to values_path
    else
      render :new
    end
  end

  def show
    @value = Value.find(params[:id])
    @reflection = Reflection.new
    @reflection_data = @value.reflection if @value.reflection&.created_at&.today?
  end

  def edit
    @value = Value.find(params[:id])
  end

  def update
    @value = Value.find(params[:id])
    if @value.update(value_params)
      redirect_to values_path
    else
      render :edit
    end
  end

  def destroy
    value = Value.find(params[:id])
    value.destroy
    redirect_to values_path
  end

  private
  def value_params
    params.require(:value).permit(:title, :content).merge(user_id: current_user.id)
  end
end
