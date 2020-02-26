class WorkoutlogsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @workoutlog = current_user.workoutlogs.build(workoutlog_params)
    if @workoutlog.save
      flash[:success] = 'お疲れ様です！work out log を記録しました！'
      redirect_to root_url
    else 
      @workoutlogs = current_user.workoutlogs.order(id: :desc).page([params])
      flash[:danger] = 'work out log を記録できませんでした'
      render 'toppage#index'
    end
  end

  def destroy
    @workoutlog.destroy
    flash[:success] = 'work out logを削除しました'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def workoutlog_params
    params.require(:workoutlog).permit(:content)
  end
  
  def correct_user
    @workoutlog = current_user.workoutlogs.find_by(id: params[:id])
    unless @workoutlog
      redirect_to root_url
    end
  end
  
end
