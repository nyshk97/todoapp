class TasksController < ApplicationController
  before_action :logged_in_user, only:[:create, :edit, :update, :destroy]
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    # @task = Task.new(task_params)
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = "タスクを追加しました。"
      redirect_to tasks_url
    else
      flash.now[:danger] = "登録に失敗しました。"
      render 'tasks/new'
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:success] = "タスクを修正しました。"
      redirect_to tasks_url
    else
      flash.now[:danger] = "更新に失敗しました。"
      render 'tasks/edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:success] = "タスクを削除しました。"
    redirect_to tasks_url
  end

  private
    def task_params
      params.require(:task).permit(:title)
    end
end