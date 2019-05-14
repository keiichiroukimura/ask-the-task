class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :ensure_correct_user, only: [:show]
  before_action :logged_in, only: [:new]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_path(@user.id)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      redirect_to tasks_path
    end
  end
  
  def logged_in
    if logged_in?
      redirect_to tasks_path
    end
  end
end
