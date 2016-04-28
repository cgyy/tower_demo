class User < ActiveRecord::Base
  has_many :accesses
  has_many :events, as: :source
  
  has_many :accesses
  has_many :projects, through: :accesses

  # 普通用户可以对自己创建的任务进行任何操作
  # 只有管理员可以删除其他人创建的任务
  def can?(action, project)
    access = self.accesses.find_by(project_id: project.id)
    return false if access.blank? || (action == :manage && !access.admin?)
    true
  end

end
