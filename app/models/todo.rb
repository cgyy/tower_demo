class Todo < ActiveRecord::Base
  belongs_to :project
  belongs_to :list
  belongs_to :assignee, class_name: "User"
  belongs_to :finisher, class_name: "User"

  validates :name, presence: true

  scope :unclassified, -> { where list_id: nil }
  scope :unfinished, -> { where finished_at: nil }
  scope :finished, -> { where.not finished_at: nil }
  scope :active, -> { where deleted_at: nil }
end
