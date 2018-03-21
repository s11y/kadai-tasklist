class TasksController < ApplicationController
  
  before_action :set_task, only: [:show, :edit, :update]
  before_action :require_user_logged_in, only: [:new, :show, :index]
  before_action :correct_user, only: [:destroy, :edit]
  
  def index
    if current_user
      @tasks = current_user.tasks.all
    end
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'Taskが正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Taskが投稿されませんでした'
      render :new
    end
  end
  
  def new
    @task = Task.new
  end
  
  def edit
  end
  
  def show
  end
  
  def update
    
    if @task.update(task_params)
      flash[:success] = 'Taskが正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Taskが投稿されませんでした'
      render :edit
    end
    
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = 'Taskが正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
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
