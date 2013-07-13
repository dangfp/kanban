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
