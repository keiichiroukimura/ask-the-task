class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user,{only: [:edit, :update,:destroy,]}
    PER = 3
  def index
    if params[:title].present? && params[:status].present?
      @tasks = Task.search_title(params[:title])
                   .search_status(params[:status])
    elsif params[:title].present?  
      @tasks = Task.search_title(params[:title]) 
    elsif params[:status].present?
      @tasks = Task.search_status(params[:status])
    elsif params[:sort_priority] == 'true'
      @tasks = Task.sort_priority(params[:sort_priority])
    elsif params[:sort_expired] == 'true'
      @tasks = Task.sort_expired(params[:sort_expired])
    else
      @tasks = Task.order(created_at: "DESC")
    end 
      @tasks = @tasks.my_tasks(current_user.id).page(params[:page]).per(PER) 
  end

  def new
    @task = Task.new
  end

  def show
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      redirect_to tasks_path(@task.id) , notice: 'タスクを作成'
    else
      render 'new'
    end
  end
  
  def edit
  end

  def update
    @task.user_id = current_user.id
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'タスクを更新'
    else
      render 'new'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'タスクを削除しました。'
  end

  private
  
  def task_params
    params.require(:task).permit(:title, :content, :deadline, :priority, :status, :user_id)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def ensure_correct_user
      
    
      redirect_to tasks_path unless @task.user_id == current_user.id
    end
end
