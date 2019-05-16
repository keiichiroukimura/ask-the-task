class Admin::UsersController < ApplicationController
  before_action :require_admin
  PER = 3
  def index
    @users = User.all
  end
  
  def show 
    @tasks = Task.includes(:user).where(user_id: params[:id]).page(page_display).per(PER)
  end
  
  def new
    @user = User.new 
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path(@user), notice: "「#{@user.name}」を登録しました。"
    else
      render 'new'
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "「#{@user.name}」を更新しました。"
    else
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "「#{@user.name}」を削除しました。"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end

  def page_display
    params[:page]
  end

  def set_user
    @user = User.find(params[:id])
  end
end
