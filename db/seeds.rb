# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#
# Create admin and applications groups, for right management
#
g = Group.create(:name => "root", :description => "Users in this groups have all rights on lil_auth, you may propagate this on ur service")
Group.create(:name => "apps", :description => "Users in this groups can register applications, and edit their own apps")
root = User.create(:email => "root@lil_auth.epitech.eu", :password => "changeme")
root.groups << g

