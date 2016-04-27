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

  before_save do |r|
    return if r.new_record?

    if r.finished_at_changed? && r.finished_at_was.blank?
      message = "完成了任务"
    elsif  
    end 

  end

end
