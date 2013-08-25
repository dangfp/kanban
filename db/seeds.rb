#encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
['综合接入网关','短信办公室','政企彩信报','综合接入网关接口','综合接入网关与业务插件接口','性能'].each do |name|
 Project.create!(name: name)
end
#
# ['模块1','模块2','模块3'].each do |name|
#   feature = Feature.new
#   feature.name = name
#   feature.project_id = Project.first.id
#   feature.save
# end
#
['用户管理','安全管理','维护管理','插件管理','通讯录操作','日志服务','数据统计服务','业务插件鉴权','路由处理','通信详单日志','流量控制','IMS功能','有效期检测'].each do |name|
 Project.first.features.create!(name: name)
end
#
['模块4','模块5','模块6'].each do |name|
 Project.all.second.features.create!(name: name)
end
# 
#DEFAULT_PASSWORD = '123456789'
#
#developer = Developer.create!(email: 'zhangsan@163.com',
#                              password: DEFAULT_PASSWORD,
#                              password_confirmation: DEFAULT_PASSWORD,
#                              name: '张三'
#                             )
#developer.save!
#
#
#tester = Tester.create!(email: 'lisi@163.com',
#                        password: DEFAULT_PASSWORD,
#                        password_confirmation: DEFAULT_PASSWORD,
#                        name: '李四'
#                       )
#tester.save!
#
#manager= Manager.create!(email: 'manager@leadtone.com',
#                        password: DEFAULT_PASSWORD,
#                        password_confirmation: DEFAULT_PASSWORD,
#                        name: '管理员'
#                       )
#manager.save!

DEFAULT_PASSWORD = '123456789'
 rooter = User.create!(:email => 'root@example.com',
                 :password => DEFAULT_PASSWORD,  
                 :password_confirmation => DEFAULT_PASSWORD,
                 :name => '老大'
                )
 rooter.roles << :root           
 rooter.save!                    

 developer = User.create!(:email => 'lisi@example.com',
                 :password => DEFAULT_PASSWORD,  
                 :password_confirmation => DEFAULT_PASSWORD,
                 :name => '开发李四'
                )
 developer.roles << :developer
 developer.save!                    


 tester = User.create!(:email => 'wangwu@126.com',
                  :password => DEFAULT_PASSWORD,  
                  :password_confirmation => DEFAULT_PASSWORD,
                  :name => '测试王五'
                 )
 tester.roles << :tester
 tester.save!       


 puts "=== Root user created ==="
 puts "Email: #{rooter.email}"   
 puts "Password: #{DEFAULT_PASSWORD}" 
 puts "Name: #{rooter.name}"

 puts "=== Developer user created ==="
 puts "Email: #{developer.email}"   
 puts "Password: #{DEFAULT_PASSWORD}"
 puts "Name: #{developer.name}" 

 puts "=== Tester user created ==="
 puts "Email: #{tester.email}"   
 puts "Password: #{DEFAULT_PASSWORD}"
 puts "Name: #{tester.name}" 
