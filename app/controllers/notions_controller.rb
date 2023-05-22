class NotionsController < ApplicationController
  def index
    @notions = Notion.all
  end

  def show
    @notion = Notion.find(params[:id])
    respond_to do |format|
      format.json { render json: @notion }
    end
  end
end
