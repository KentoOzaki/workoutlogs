class FavoritesController < ApplicationController
  #ログインが必要
  before_action :require_user_logged_in
  
  def create
    other_workoutlog = Workoutlog.find(params[:workoutlog_id])
    current_user.like(other_workoutlog)
    flash[:success] = 'お気に入りに登録しました'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    other_workoutlog = Workoutlog.find(params[:workoutlog_id])
    current_user.unlike(other_workoutlog)
    flash[:success] = 'お気に入りから削除しました'
    redirect_back(fallback_location: root_path)
  end
end
