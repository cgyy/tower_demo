class Event < ActiveRecord::Base
  belongs_to :project
  belongs_to :team
  belongs_to :user
  belongs_to :source, polymorphic: true

  # 推送事件以简单实现动态的连续加载
  after_create { |r| EventQueue.push(r) }


  def source_url
    name, path = 
    case source.class.name
    when "Todo"
      [source.name, "/projects/#{project_id}/todos/#{source_id}"]
    when "Comment"
      comment_type = (source.source_type == "Todo")? "todos" : "lists"
      [source.source.name, "/projects/#{project_id}/#{comment_type}/#{source.source_id}"]
    when "Project"
      [source.name, "#"]
    when "List"
      [source.name, "/projects/#{project_id}/lists/#{source_id}"]
    end

    "<a href='#{path}'>#{name}</a>"
  end

  def full_message
    content = "#{message}: #{source_url}"
    content += "<br /><p>#{source.content}</p>" if source_type == "Comment"
    return content.html_safe
    content = (source_type == "Comment") ? "#{message} <br /><p>#{source.content}</p>" : message
    (content + source_url).html_safe
  end


  class << self
    # 将events按项目分组
    def group_sorted_by_project(events)
      groups = []
      events.each_with_index do |event, index|
        if index > 0 && event.project_id == events[index - 1].project_id
          groups.last[event.project] << event
        else
          groups << { event.project => [event] }
        end
      end

      groups
    end


    def add_project(project)
      Event.create(
        team_id: project.team_id, 
        project_id: project.id, 
        user_id: project.creator_id,
        source: project, 
        behaviour: "create_project",
        message: "创建了项目"
      )
    end

    def add_list(list)
      Event.create(
        team_id: list.project.team_id, 
        project_id: list.project.id, 
        user_id: list.creator_id,
        source: list, 
        behaviour: "create_list",
        message: "创建了任务清单"
      )
    end

    def add_todo(todo)
      event = Event.new(
        team_id: todo.project.team_id, 
        project_id: todo.project.id, 
        user_id: todo.creator_id,
        source: todo,
        behaviour: "create_todo"
      )
      assign = (todo.assignee_id)? "为#{todo.assignee.name}" : ""
      event.message = "#{assign} 创建了任务"
      event.save
    end

    def add_todo_change(todo, message)
      Event.create(
        team_id: todo.project.team_id, 
        project_id: todo.project.id, 
        user_id: todo.updater_id,
        source: todo,
        behaviour: "update_todo",
        message: message
      )
    end

    def add_comment(comment)
      event = Event.new(
        team_id: comment.source.project.team_id, 
        project_id: comment.source.project.id, 
        user_id: comment.creator_id,
        source: comment,
        behaviour: "create_comment"
      )
      target = (comment.source_type == "Todo")? "任务" : "任务清单"
      event.message = "回复了#{target}"
      event.save
    end




  end
  
end
