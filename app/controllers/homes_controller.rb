class HomesController < ApplicationController
  before_action :move_to_top

  def index
    @famous_quotes = current_user.famous_quotes
    @famous_quote = @famous_quotes.find_by(displayed: true)
  end

  private
  def move_to_top
    unless user_signed_in?
      redirect_to tops_path
    end
  end
end
