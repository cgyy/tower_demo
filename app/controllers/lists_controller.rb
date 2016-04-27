class ListsController < ApplicationController

  before_action :set_project

  def new
    @list = List.new
  end

  def create
    @list = List.new(params.require(:list).permit(:name, :description).
      merge(project_id: @project.id, creator_id: 1, updater_id: 1))

    if @list.save
      redirect_to project_todos_path(@project)
    else
      flash[:alert] = @list.errors.messages.map { |k,vs| "#{k}:#{vs.join(',')}"}.join(";")
      redirect_to request.referer
    end     
  end


  private

  def set_project
    @project = Project.find(params[:project_id])
  end

end