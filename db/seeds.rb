# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
PayType.create(name: 'Monthly')
PayType.create(name: 'Hourly')
PayType.create(name: 'Hourly(Fixed)')
PayType.create(name: 'Weekly')
PayType.create(name: 'Daily')




