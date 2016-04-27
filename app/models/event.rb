class Event < ActiveRecord::Base
  belongs_to :project
  belongs_to :team
  belongs_to :user
  belongs_to :source, polymorphic: true

  class << self

    def add_project(project)
      Event.create(
        team_id: project.team_id, 
        project_id: project.id, 
        user_id: project.creator_id,
        source: project, 
        behaviour: "create_project",
        message: "创建了项目: #{project.name}"
      )
    end

    def add_list(list)
      Event.create(
        team_id: list.project.team_id, 
        project_id: list.project.id, 
        user_id: list.creator_id,
        source: list, 
        behaviour: "create_list",
        message: "创建了任务清单: #{list.name}"
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
      event.message = "#{assign} 创建了任务: #{todo.name}"
      event.save
    end

    def add_todo_change(todo, message)
      Event.create(
        team_id: todo.project.team_id, 
        project_id: todo.project.id, 
        user_id: todo.updater_id,
        source: todo,
        behaviour: "update_todo"
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
      event.message = "回复了#{target}: #{comment.source.name}"
      event.save
    end




  end
  
end
