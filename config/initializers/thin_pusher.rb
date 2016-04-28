# 简单实现用户动态

require 'sinatra/async'

class ThinPusher < Sinatra::Base
  include ApplicationHelper
  register Sinatra::Async

  TIMEOUT = 30


  aget '/poll' do
    content_type 'application/json'

    poll_cb = lambda do |event|
      self.body({
        status: 'success', 
        event: {
          id: event.id,
          project_id: event.project_id,
          project_name: event.project.name,
          user_name: event.user.name,
          user_avatar: event.user.avatar_url,
          date: event.created_at.to_date,
          time: event.created_at.strftime("%H:%M"),
          message: event.full_message
        } 
      }.to_json)
    end

    EventQueue.wait_call(&poll_cb)

    # 超时
    EM.add_timer(TIMEOUT) do
      EventQueue.cancel_call(&poll_cb)
      self.body({:status => 'timeout'}.to_json)
    end

    # 连接断开
    on_close do
      EventQueue.cancel_call(&poll_cb)
    end

  end

end

class EventQueue
  @queue = []
  
  class << self
    def wait_call(&cb)
      @queue << cb
    end

    def push(event)
      while cb = @queue.shift
        cb.call(event)
      end
    end

    def cancel_call(&cb)
      @queue.delete(cb)
    end

  end
end