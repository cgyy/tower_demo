class EventsController < ApplicationController
  
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
    EventQueue.push({a:1})
    render :text => ""
  end
end