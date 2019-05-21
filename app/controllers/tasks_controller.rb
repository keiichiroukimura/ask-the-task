class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user,{only: [:edit, :update,:destroy,]}
    PER = 3
  def index
    if title_status_exists
      @tasks = Task.search_title(included_title)
                   .search_status(included_status)
    elsif title_exists
      @tasks = Task.search_title(included_title) 
    elsif status_exists
      @tasks = Task.search_status(included_status)
    elsif sort_priority_true
      @tasks = Task.sort_priority(included_sort_priority)
    elsif sort_expired_true 
      @tasks = Task.sort_expired(included_sort_expired)
    else
      @tasks = Task.order(created_at: "DESC")
    end 
      @tasks = @tasks.where(user_id: current_user.id).page(page_display).per(PER)
      #@tasks = @tasks.my_tasks(current_user.id).page(page_display).per(PER)
      #serch_and_sort
  end

  def new
    @task = Task.new 
    # @labels = @task.favorites.find_by(label_id: params[:id])
  end

  def show
  end

  def create
    binding.pry
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    # @labels = @task.favorites.find_by(label_id: params[:id])
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
    params.require(:task).permit(:title, :content, :deadline, :priority, :status, :user_id, label_ids:[])
  end

  def set_task
    @task = Task.find(params[:id])
  end
  
  def title_exists
    params[:title].present?
  end 
  
  def status_exists
    params[:status].present?
  end
  
  def title_status_exists
    params[:title] && params[:status]
  end
  
  def included_title
    params[:title]
  end

  def included_status
    params[:status]
  end
  
  def sort_priority_true 
    params[:sort_priority] == 'true'
  end

  def sort_expired_true 
    params[:sort_expired] == 'true'
  end

  def included_sort_priority
    params[:sort_priority]
  end

  def included_sort_expired
    params[:sort_expired]
  end

  def page_display
    params[:page]
  end
  #def serch_and_sort
    # if params[:title].present? && params[:status].present?
    #   @tasks = Task.search_title(params[:title])
    #                .search_status(params[:status])
    # elsif params[:title].present?
    #   @tasks = Task.search_title(params[:title]) 
    # elsif params[:status].present?
    #   @tasks = Task.search_status(params[:status])
    # elsif params[:sort_priority] == 'true'
    #   @tasks = Task.sort_priority(params[:sort_priority])
    # elsif params[:sort_expired] == 'true'
    #   @tasks = Task.sort_expired(params[:sort_expired])
    # else
    #   @tasks = Task.order(created_at: "DESC")
    # end 
    #   @tasks = @tasks.my_tasks(current_user.id).page(params[:page]).per(PER)  
  #end

  def ensure_correct_user
    redirect_to tasks_path unless @task.user_id == current_user.id
  end
end
