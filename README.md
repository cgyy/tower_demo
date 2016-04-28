# tower 后端测试

### 安装部署
```ruby
bundle install
rake db:create
rake db:migrate
rake db:seed # 插入一些user、team、project、access等基础模型的测试数据 
```

###  运行
```ruby
rails s 

# 项目使用了thin 来实现“动态”的持续加载 若出现超时错误，可以把请求的的超时时间设短点
# 如 thin start -t 10
```

### 测试方法

打开2个标签页
从 http://localhost:3000/projects/1/todos 进行任务的各项操作
查看 http://localhost:3000/teams/1/events 的输出结果(不需刷新)

events_controller#index 接口地址为 GET /teams/1/events.json
参数如下: 页码 page, 每页个数 per_page, 起始ID since_id 用户ID user_id, 4个参数皆可空


### 其他

因为没实现认证模块，目前是把当前用户固定设成ID为1的用户,测试权限的场合请在applicaton_controller修改