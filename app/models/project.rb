class Project < ActiveRecord::Base
  has_many :todos
  has_many :lists

  has_many :accesses
  has_many :users, through: :accesses

end