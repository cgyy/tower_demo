class Todo < ActiveRecord::Base
  belongs_to :project
  belongs_to :list
  belongs_to :assignee, class_name: "User"
  belongs_to :finisher, class_name: "User"
  belongs_to :creator, class_name: "User"

  has_many :comments, as: :source

  validates :name, presence: true

  scope :unclassified, -> { where list_id: nil }
  scope :unfinished, -> { where finished_at: nil }
  scope :finished, -> { where.not finished_at: nil }
  scope :active, -> { where deleted_at: nil }

  after_create { |r| Event.add_todo(r)  }

  before_save :set_events

  
  def set_events
    return if self.new_record?

    message = 
    if finished_at_changed? && finished_at_was.blank?
      "完成了任务"
    elsif deleted_at_changed? && deleted_at_was.blank?
      "删除了任务"
    elsif assignee_id_changed?
      if assignee_id.blank?
        "取消了#{User.find(assignee_id_was).name}的任务"
      elsif assignee_id_was.blank?
        "给 #{self.assignee.name} 指派了任务"
      else
        "把 #{User.find(assignee_id_was).name} 的任务指派给了 #{self.assignee.name}"
      end
    elsif due_date_changed?
      " 将任务完成时间从 #{due_date_was || '没有截止日期'} 修改为 #{due_date || '没有截止日期'}"      
    end

    Event.add_todo_change(self, message) if message.present?
  end

end
