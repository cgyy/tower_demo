class Comment < ActiveRecord::Base
  belongs_to :source, polymorphic: true

  belongs_to :creator, class_name: "User"

  after_create { |r| Event.add_comment(r)  }

end
