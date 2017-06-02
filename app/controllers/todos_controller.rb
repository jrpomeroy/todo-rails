class TodosController < ApplicationController
  def index
    validate_session
    @user = User.find(params[:user_id])
    if is_json
      render json: @user.todos
    else
      @todos_closed = @user.todos.select { |todo| todo.complete }
      @todos_open = @user.todos.select { |todo| !todo.complete }
    end
  end

  def new
    validate_session
    @todo = Todo.new
    @user = User.find(params[:user_id])
  end

  def edit
    validate_session
    @user = User.find(params[:user_id])
    @todo = @user.todos.find(params[:id])
    @users = User.all
  end

  def show
    validate_session
    @user = User.find(params[:user_id])
    @todo = @user.todos.find(params[:id])
    if is_json
      render json: @todo
    end
  end

  def create
    validate_session
    @user = User.find(params[:user_id])
    new_todo_params = todo_params
    new_todo_params['user_id'] = @user.id
    @todo = Todo.new(new_todo_params)
    if @todo.save
      redirect_to user_todos_path(@user)
    else
      render 'new'
    end
  end

  def update
    validate_session
    @user = User.find(params[:user_id])
    @todo = @user.todos.find(params[:id])
    if @todo.update(todo_params)
      redirect_to user_todos_path(@user)
    else
      @users = User.all
      render 'edit'
    end
  end

  def destroy
    validate_session
    user = User.find(params[:user_id])
    todo = user.todos.find(params[:id])
    todo.destroy
    redirect_to user_todos_path(user)
  end

  private
    def todo_params
      params.require(:todo).permit(:description, :complete, :user_id)
    end

    def is_json
      # Determine if JSON should be returned based on the accept header or query parameter
      (request.headers["accept"].include? "application/json") || request.query_parameters["json"] == "true"
    end

    def validate_session
      # If the user parameter doesn't match the session user the logout
      if session[:user_id].to_s != params[:user_id].to_s
        redirect_to login_logout_path
      end
    end
end
