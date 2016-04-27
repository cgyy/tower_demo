class List < ActiveRecord::Base
  belongs_to :project
  belongs_to :creator, class_name: "User"

  has_many :todos
  has_many :comments, as: :source

  validates :name, presence: true

  after_create { |r| Event.add_list(r)  }
end
