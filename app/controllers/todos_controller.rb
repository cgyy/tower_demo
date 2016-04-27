class TodosController < ApplicationController

  before_action :set_project

  def index
    @todos = @project.todos.unclassified.unfinished.active
    @lists = @project.lists
    @finished_todos = @project.todos.finished.active
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
    @todo.assign_attributes(params.require(:todo).permit(:name, :assignee_id, :due_date))

    if @todo.save
      redirect_to project_todos_path(@project)
    else
      flash[:alert] = @todo.errors.messages.map { |k,vs| "#{k}:#{vs.join(',')}"}.join(";")
      redirect_to request.referer
    end

  end

  def destroy
    @todo = Todo.find(params[:id])
    forbidden if false

    @todo.update_attributes(deleted_at: Time.now, updater_id: current_user.id )
    redirect_to project_todos_path(@project)
  end

  def finish
    @todo = Todo.find(params[:id])
    @todo.update_attributes(finisher_id: current_user.id, finished_at: Time.now)
    redirect_to project_todos_path(@project)
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

end