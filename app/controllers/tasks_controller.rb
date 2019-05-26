class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_labels, only: [:index, :new, :edit, :create]
  before_action :ensure_correct_user,{only: [:edit, :update,:destroy]}
    PER = 3
  def index
    if title_status_exists?
      @tasks = Task.search_title(included_title)
                   .search_status(included_status)
    elsif title_exists?
      @tasks = Task.search_title(included_title) 
    elsif status_exists?
      @tasks = Task.search_status(included_status)
    elsif label_exists?
      @labels = Label.all
        @labels.each do |label|
          if label.content == included_label
            label_id =  label.id
            label = Label.find(label_id)
            @tasks = label.favorite_tasks
          end
        end
    elsif sort_priority_true
      @tasks = Task.sort_priority(included_sort_priority)
    elsif sort_expired_true 
      @tasks = Task.sort_expired(included_sort_expired)
    else
      @tasks = Task.all.order(created_at: "DESC")
    end 
      @tasks = @tasks.where(user_id: current_user.id).page(page_display).per(PER) 
  end
  
  def new
    @task = Task.new 
  end

  def show
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      # if @labels
      # i = 0
      #   while i < @labels.length  do
      #     @favorite.create(label_id: @labels[i])
      #     i += 1
      #   end
      # end
      redirect_to tasks_path, notice: 'タスクを作成'
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
        render 'edit'
      end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'タスクを削除しました。'
  end

  private
  
  def task_params
    params.require(:task).permit(:title, :content, :deadline, :priority, :status, :user_id, label_ids: [])
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def set_labels
    @labels = Label.all
  end
  
  def title_exists? 
    params[:title].present?
  end 
  
  def status_exists?
    params[:status].present?
  end
  
  def title_status_exists?
    params[:title].present? && params[:status].present?
  end
  
  def label_exists?
    params[:label_id].present?
  end

  def included_title
    params[:title]
  end

  def included_status
    params[:status]
  end
  
  def included_label
    params[:label_id]
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

  def ensure_correct_user
    redirect_to tasks_path unless @task.user_id == current_user.id
  end
end
