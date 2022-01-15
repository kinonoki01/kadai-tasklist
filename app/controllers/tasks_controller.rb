class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :find_task, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = current_user.tasks.build
    @pagy, @tasks = pagy(current_user.tasks.order(id: :desc))
  end
  
  def show
    if !@task
      flash[:warning] = '選択したIDのタスクは存在しません'
      redirect_to root_url
    end
  end
  
  def new
    @task = current_user.tasks.build
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'タスクを作成しました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクの作成に失敗しました'
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = 'タスクを更新しました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクの更新に失敗しました'
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    flash[:success] = 'タスクを削除しました'
    redirect_to tasks_url
  end
  
  private
  
  def task_params
    params.require(:task).permit(:content, :status, :user_id)
  end
  
  def find_task
    @task = current_user.tasks.find_by(id: params[:id])
  end
end
