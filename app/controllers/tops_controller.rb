class TopsController < ApplicationController
  before_action :move_to_home

  def index
    
  end

  private
  def move_to_home
    if user_signed_in?
      redirect_to homes_path
    end
  end
end
