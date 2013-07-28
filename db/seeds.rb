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

# ['模块1','模块2','模块3'].each do |name|
#   feature = Feature.new
#   feature.name = name
#   feature.project_id = Project.first.id
#   feature.save
# end

['用户管理','安全管理','维护管理','插件管理','通讯录操作','日志服务','数据统计服务','业务插件鉴权','路由处理','通信详单日志','流量控制','IMS功能','有效期检测'].each do |name|
  Project.first.features.create!(name: name)
end

['模块4','模块5','模块6'].each do |name|
  Project.all.second.features.create!(name: name)
end
 
Developer.create!(email: "zhangsan@163.com", password: "123456abc", password_confirmation: "123456abc")

Tester.create!(email: "lisi@163.com", password: "123456abc", password_confirmation: "123456abc")
