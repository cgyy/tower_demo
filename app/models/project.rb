class Project < ActiveRecord::Base
  belongs_to :team
  belongs_to :creator, class_name: "User"

  has_many :todos
  has_many :lists

  has_many :accesses
  has_many :users, through: :accesses

  after_create { |r| Event.add_project(r)  }

end