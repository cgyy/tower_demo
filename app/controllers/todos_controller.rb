class TodosController < ApplicationController

  before_action :set_project, :authorize_project

  def index
    @todos = @project.todos.includes(:assignee).unclassified.unfinished.active
    @lists = @project.lists.includes(:todos)
    @finished_todos = @project.todos.includes(:assignee).finished.active
    @deletable = current_user.can?(:manage, @project)
  end

  def new
    @todo = Todo.new
  end

  def edit
    @todo = Todo.find(params[:id])
  end

  def create
    @todo = Todo.new(params.require(:todo).permit(:name, :assignee_id, :due_date, :list_id).
      merge(project_id: @project.id, creator_id: current_user.id, updater_id: current_user.id ))

    if @todo.save
      redirect_to project_todos_path(@project)
    else
      flash[:alert] = @todo.errors.messages.map { |k,vs| "#{k}:#{vs.join(',')}"}.join(";")
      redirect_to request.referer
    end
  end

  def update
    @todo = Todo.find(params[:id])
    @todo.assign_attributes(params.require(:todo).permit(:name, :assignee_id, :due_date).merge(updater_id: current_user.id))

    if @todo.save
      redirect_to project_todos_path(@project)
    else
      flash[:alert] = @todo.errors.messages.map { |k,vs| "#{k}:#{vs.join(',')}"}.join(";")
      redirect_to request.referer
    end

  end

  def destroy
    @todo = Todo.find(params[:id])
    return forbidden unless  current_user.can?(:manage, @project) # 只有管理员或创建者才能删除任务

    @todo.update_attributes(deleted_at: Time.now, updater_id: current_user.id )
    redirect_to project_todos_path(@project)
  end

  # 完成任务
  def finish
    @todo = Todo.find(params[:id])
    @todo.update_attributes(finisher_id: current_user.id, finished_at: Time.now, updater_id: current_user.id)
    redirect_to project_todos_path(@project)
  end

  # 添加评论
  def comment
    @todo = Todo.find(params[:id])
    @comment = Comment.new
    if request.method == "POST"
      @comment.update_attributes(params.require(:comment).permit(:content).merge(source: @todo, creator_id: current_user.id))
      redirect_to project_todos_path(@project)
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def authorize_project
    forbidden unless current_user.can?(:visit, @project)
  end

end