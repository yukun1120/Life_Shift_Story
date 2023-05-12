class HomesController < ApplicationController
  before_action :move_to_top

  def index
    
  end

  private
  def move_to_top
    unless user_signed_in?
      redirect_to tops_path
    end
  end
end
