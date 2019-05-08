class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    #@tasks = Task.search_task(params[:title],params[:status],params[:sort_expired])
    ##@tasks = Task.sort_expired(params[:sort_expired]) if params[:sort_expired] == 'true'
    

    if params[:title].present? && params[:status].present?
      @tasks = Task.search_title(params[:title])
                   .search_status(params[:status])
    elsif params[:title].present?  
      @tasks = Task.search_title(params[:title]) 
    elsif params[:status].present?
      @tasks = Task.search_status(params[:status])
    elsif params[:sort_expired] == 'true'
      @tasks = Task.sort_expired(params[:sort_expired])
    else
      @tasks = Task.order(created_at: "DESC")
    end 
  end

  def new
    @task = Task.new
  end

  def show
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task.id) , notice: 'タスクを作成'
    else
      render 'new'
    end
  end
  
  def edit
  end

  def update
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
    params.require(:task).permit(:title, :content, :deadline, :priority, :status)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
