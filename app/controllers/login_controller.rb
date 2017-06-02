class LoginController < ApplicationController
  def index
    # If we already have a valid session then go to the todo list
    if session[:user_id]
      @user = User.find(session[:user_id])
      redirect_to user_todos_path(@user)
    end
  end

  def logout
    # Clear the session and go back to the login page
    reset_session
    redirect_to login_index_path
  end

  def login
    @user = User.find_by(username: params[:user][:username])
    if @user && @user.password == params[:user][:password]
      reset_session
      session[:user_id] = @user.id
      redirect_to user_todos_path(@user)
    else
      @error = "Invalid login credentials"
      render login_index_path
    end
  end
end
