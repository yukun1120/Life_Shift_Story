class FamousQuotesController < ApplicationController
  before_action :set_famous_quote, only: [:edit, :update, :destroy]

  def index
    @famous_quotes = current_user.famous_quotes
  end

  def new
    @famous_quote = FamousQuote.new
  end

  def create
    @famous_quote = FamousQuote.new(famous_quote_params)
    if @famous_quote.valid?
      @famous_quote.save
      redirect_to famous_quotes_path
    else
      
      render :new

    end
  end

  def edit
  end

  def update
    if @famous_quote.update(famous_quote_params)
      redirect_to famous_quotes_path
    else
      render :edit
    end
  end

  def destroy
    @famous_quote.destroy
    redirect_to famous_quotes_path
  end

  private
  def set_famous_quote
    @famous_quote = FamousQuote.find(params[:id])
  end

  def famous_quote_params
    params.require(:famous_quote).permit(:phrase).merge(user_id: current_user.id)
  end
  
end
