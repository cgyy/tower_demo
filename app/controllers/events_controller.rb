class EventsController < ApplicationController

  before_action :set_team, :authorize_team


  # == 事件列表
  #
  # GET /teams/:team_id/events
  #
  # ==== Parameters
  # user_id :: 用户ID
  # since_id :: 最后一条的ID
  # page :: 页数
  # per_page :: 每页个数
  #
  def index
    page, per_page = (params[:page] || 1).to_i, (params[:per_page] || 50).to_i

    events = @team.events.includes(:user, :source, :project)
    events = events.where(user_id: params[:user_id].to_i) if params[:user_id].present?
    events = events.where("id > ?", params[:since_id].to_i) if params[:since_id].present?
    @events = events.order("created_at DESC").limit("#{(page-1) * per_page}, #{per_page}")
    
    respond_to do |format|
        format.html 
        
        format.json { 
          render json: @events.map { |event |
            { 
              id: event.id,
              project_id: event.project_id,
              message: event.message,
              url: event.source_url,      
              created_at: event.created_at.to_s(:db),
              user: event.user.attributes.slice('name', 'avatar_url')
            }
          }
        }
      end

  end


  private

  def set_team
    @team = Team.find(params[:team_id])
    
  end

  def authorize_team
    forbidden unless @team.users.where(id: current_user.id).exists?
  end


end