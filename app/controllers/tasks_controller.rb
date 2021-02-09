class TasksController < ApplicationController
  before_action :correct_user, only: [:edit, :show, :update, :destroy]
  before_action :require_user_logged_in
  
  def index
    @tasks = current_user.tasks
  end

  def show
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = '正常に作成されました'
      redirect_to task_path(@task)
    else
      flash.now[:danger] = '作成に失敗しました'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = '正常に更新されました'
      redirect_to task_path(@task)
    else
      flash.now[:danger] = '更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @task.destroy
  
    flash[:success] = '正常に削除されました'
    redirect_to root_url
  end
  
  private
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
