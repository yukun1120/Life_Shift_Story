class ValuesController < ApplicationController
  def index
    @values = Value.includes(:user)
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
    
  end

  def edit
    
  end

  def update
    
  end

  def destroy
    
  end

  private
  def value_params
    params.require(:value).permit(:title, :content).merge(user_id: current_user.id)
  end
end
