class LifeLogsController < ApplicationController
  def index
    @good_things = Good.none
    @diaries = Diary.none

    if params[:keyword].present? || params[:date].present?
      if params[:date].present?
        date = Date.parse(params[:date])
        @good_things = current_user.goods.where('DATE(updated_at) = ?', date)
        @diaries = current_user.diaries.where('DATE(updated_at) = ?', date)
      else
        @good_things = current_user.goods
        @diaries = current_user.diaries
      end

      if params[:keyword].present?
        @good_things = @good_things.where('good_thing LIKE ?', "%#{params[:keyword]}%")
        @diaries = @diaries.where('title LIKE ? OR content LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
      end
    end
  end
end
