class User < ActiveRecord::Base

  # 普通用户可以对自己创建的任务进行任何操作
  # 只有管理员可以删除其他人创建的任务
  def can
  end
end
