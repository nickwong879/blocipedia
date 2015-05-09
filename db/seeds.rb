# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

# Create users

10.times do 
	user = User.new(
		username: Faker::Name.name,
		email:  Faker::Internet.email,
		password:  Faker::Lorem.characters(10) 
		)
	user.skip_confirmation!
	user.save!
end
users = User.all

# Create wikis

50.times do
	wiki = Wiki.create!(
		title:  Faker::Lorem.sentence,
		body:  Faker::Lorem.paragraph
		)
		# Setting created_at times
	wiki.update_attributes!(created_at: rand(10.minutes .. 1.year).ago)
end
wikis = Wiki.all

# Create an admin user
admin = User.new(
	username:  'Admin',
	email:  'admin@example.com',
	password:  'helloworld',
	role:  'admin'
	)
	admin.skip_confirmation!
	admin.save!

# report upon completion
puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
