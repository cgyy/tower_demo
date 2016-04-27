class ProjectsController < ApplicationController

  def index
    @projects = current_team.projects.where(id: current_user.accesses.map(&:project_id))
  end

  private
  def current_team
    @current_team ||= Team.find(params[:team_id])
  end


end