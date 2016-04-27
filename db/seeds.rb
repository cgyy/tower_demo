# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)




User.create(name: "cgy001", avatar_url: "https://tower.im/assets/default_avatars/noon.jpg")
User.create(name: "tom", avatar_url: "https://tower.im/assets/default_avatars/noon.jpg")
User.create(name: "jerry", avatar_url: "https://tower.im/assets/default_avatars/noon.jpg")
	
Team.create(name: "tower开发组")
Member.create(user_id: 1, team_id: 1, admin: true)
Member.create(user_id: 2, team_id: 1, admin: false)
Member.create(user_id: 3, team_id: 1, admin: false)

Access.create(project_id: 1, user_id: 1, admin: true)
Access.create(project_id: 1, user_id: 2, admin: false)
Access.create(project_id: 2, user_id: 3, admin: true)


Project.create(name: "tower前端", description: "开发tower前端")
Project.create(name: "tower后端", description: "开发tower后端")

Todo.create(name: "创建首页", project_id: 1)
Todo.create(name: "测试首页", project_id: 1)
Todo.create(name: "创建任务页面", project_id: 1, list_id: 1)
Todo.create(name: "测试任务页面", project_id: 1, list_id: 1)

List.create(name: "开发任务功能", project_id: 1)
List.create(name: "开发通知功能", project_id: 1)