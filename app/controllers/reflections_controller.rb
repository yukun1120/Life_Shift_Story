class ReflectionsController < ApplicationController


  def create
    @reflection = Reflection.new(reflection_params)
    @reflection.completed = true

    if @reflection.save
        redirect_to values_path(completion: @reflection.value.id)
    else
        render :new
    end
  end

  
  def edit
    @reflection = Reflection.find(params[:id])
  end

  def update
    @reflection = Reflection.find(params[:id])
    if @reflection.update(reflection_params)
      redirect_to value_params(value.id)
    else
      render :edit
    end
  end

  private
  def reflection_params
    params.require(:reflection).permit(:self_assessment, :action).merge(user_id: current_user.id, value_id: params[:value_id])
  end
end
