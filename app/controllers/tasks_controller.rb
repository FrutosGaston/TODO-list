class TasksController < ApplicationController
  def index
    @tasks = @current_user.tasks
  end

  def new
    @task = Task.new
  end

  def create
    Task.create!(allowed_params.merge(user: @current_user))

    redirect_to root_path, notice: 'Task has been created'
  rescue ActiveRecord::RecordInvalid
    task
    render :new
  end

  def edit
    task
  end

  def update
    if task.update_attributes(allowed_params)
      redirect_to root_path, notice: 'Task has been updated'
    else
      render :edit
    end
  end

  def destroy
    task.destroy
    redirect_to root_path
  end

  private

  def task
    @task ||= Task.find(params[:id])
  end

  def allowed_params
    params.require(:task).permit(:description)
  end
end