class SessionsController < ApplicationController
  skip_before_action :login_required
  def new;end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to tasks_path(user.id)
    else
      redirect_to new_session_path, notice: 'Emailアドレス、パスワードをもう一度確認!!'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to new_session_path, notice: 'ログアウトしました'
    #flash[:notice] = 'ログアウトしました'
  end
end

