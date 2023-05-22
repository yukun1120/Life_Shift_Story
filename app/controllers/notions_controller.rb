class NotionsController < ApplicationController
  def index
    @notions = Notion.all
  end

  def create
    @notion = Notion.new(notion_params)
    if @notion.save
      redirect_to @notion
    else
      render 'new'
    end
  end

  def show
    @notion = Notion.find(params[:id])
    respond_to do |format|
      format.json { render json: @notion }
    end
  end

  private
  def notion_params
    params.require(:notion).permit(:title, :content)
  end
end
