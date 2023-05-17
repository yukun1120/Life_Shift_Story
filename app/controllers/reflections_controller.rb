class ReflectionsController < ApplicationController
  def create
    @reflection = Reflection.new(reflection_params)
    if @reflection.save
      @value = @reflection.value
      redirect_to values_path
    else
      @value = @reflection.value
      render "values/show"
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
