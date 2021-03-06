User.create!(name:  "Example User",
             email: "example@123.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

50.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@123.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

users = User.order(:created_at).take(20)
50.times do
  title = Faker::Lorem.sentence(1)
  content = Faker::Lorem.sentence(5)
  users.each {|user| user.microposts.create!(title: title, content: content)}
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each {|followed| user.follow(followed)}
followers.each {|follower| follower.follow(user)}
