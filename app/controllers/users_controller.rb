class UsersController < ApplicationController
  def new
    @page = 'Register'
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      session[:user_id] = @user.id
      redirect_to user_todos_path(@user)
    else
      render new_user_path
    end
  end

private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
