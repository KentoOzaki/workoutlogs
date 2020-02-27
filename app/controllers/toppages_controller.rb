class ToppagesController < ApplicationController
  def index
    if logged_in?
      @workoutlog = current_user.workoutlogs.build
      @workoutlogs = current_user.feed_workoutlogs.order(id: :desc).page(params[:page])
    end
  end
end
