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
		password:  Faker::Lorem.characters(10),
		bio: Faker::Lorem.sentences(2),
		likes: Faker::Lorem.paragraphs(5)
		)
	user.skip_confirmation!
	user.save!
end
users = User.all

# Create wikis

25.times do
	wiki = Wiki.create!(
		user: users.sample,
		title:  Faker::Lorem.sentence,
		body:  Faker::Lorem.paragraphs(8),
		private: 'true'
		)
		# Setting created_at times
	wiki.update_attributes!(created_at: rand(10.minutes .. 1.year).ago)
end
wikis = Wiki.all

25.times do
	wiki = Wiki.create!(
		user: users.sample,
		title:  Faker::Lorem.sentence,
		body:  Faker::Lorem.paragraphs(8),
		private: 'false'
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
	role:  'admin',
	bio: Faker::Lorem.sentence,
	likes: Faker::Lorem.paragraph
	)
	admin.skip_confirmation!
	admin.save!

# Create a basic user
admin = User.new(
	username:  'Basic',
	email:  'basic@example.com',
	password:  'helloworld',
	role:  nil,
	bio: Faker::Lorem.sentence,
	likes: Faker::Lorem.paragraph
	)
	admin.skip_confirmation!
	admin.save!

# Create a premium user
admin = User.new(
	username:  'Premium',
	email:  'premium@example.com',
	password:  'helloworld',
	role:  'premium',
	bio: Faker::Lorem.sentence,
	likes: Faker::Lorem.paragraph
	)
	admin.skip_confirmation!
	admin.save!

# report upon completion
puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
