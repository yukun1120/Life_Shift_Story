class ReflectionsController < ApplicationController
  def create
    @reflection = Reflection.new(reflection_params)
    if @reflection.save
      redirect_to values_path
    else
      @value = @reflection.value
      render "values/show"
    end
  end

  private
  def reflection_params
    params.require(:reflection).permit(:self_assessment, :action).merge(user_id: current_user.id, value_id: params[:value_id])
  end
end
