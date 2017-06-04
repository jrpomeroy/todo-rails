class TodosController < ApplicationController
  before_action :is_authorized
  before_action :set_user

  def index
    if is_json
      render json: @user.todos
    else
      @page = 'My ToDos'
      @todos_closed = @user.todos.select { |todo| todo.complete }
      @todos_open = @user.todos.select { |todo| !todo.complete }
    end
  end

  def new
    @page = 'Create ToDo'
    @todo = Todo.new
  end

  def edit
    @page = 'Update ToDo'
    @todo = @user.todos.find(params[:id])
    @users = User.all
  end

  def show
    @todo = @user.todos.find(params[:id])
    @page = "ToDo #{@todo.id}"
    if is_json
      render json: @todo
    end
  end

  def create
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
    @todo = @user.todos.find(params[:id])
    if @todo.update(todo_params)
      redirect_to user_todos_path(@user)
    else
      @users = User.all
      render 'edit'
    end
  end

  def destroy
    todo = @user.todos.find(params[:id])
    todo.destroy
    redirect_to user_todos_path(@user)
  end

  private
    def todo_params
      params.require(:todo).permit(:description, :complete, :user_id)
    end

    def is_json
      # Determine if JSON should be returned based on the accept header or query parameter
      (request.headers["accept"].include? "application/json") || request.query_parameters["json"] == "true"
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def is_authorized
      if !session[:user_id] || session[:user_id].to_s != params[:user_id].to_s
        if is_json
          render json: '{ "status": "401", message: "You are not authorized to perform the action." }', status: 401
        else
          flash[:notice] = "Please log in to continue"
          redirect_to login_logout_path
        end
      end
    end
end
