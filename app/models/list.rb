class List < ActiveRecord::Base
  belongs_to :project
  has_many :todos


  validates :name, presence: true
end
