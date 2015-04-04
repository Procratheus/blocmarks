require "faker"

User.delete_all
Topic.delete_all
Bookmark.delete_all

#Create Users
5.times do 
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(8...20)
    )
  user.skip_confirmation!
  user.save!
end

users = User.all

#Create Topics
10.times do 
  topic = Topic.new(
    user: users.sample,
    title: Faker::Lorem.word
    )
  topic.save!
end

topics = Topic.all

#Create Bookmarks
20.times do 
  bookmark = Bookmark.new(
    topic: topics.sample,
    url: Faker::Internet.url
    )
  bookmark.save!
end

bookmarks = Bookmark.all

puts "Seeds Finished"
puts "#{users.all.count} users created"
puts "#{topics.all.count} topics created"
puts "#{bookmarks.all.count} bookmarks created"



