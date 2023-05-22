class UserinquiriesController < ApplicationController
  def index
    @userinquiry = Userinquiry.new
  end
end
