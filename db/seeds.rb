# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Users
sherlock = User.create!(first_name: "Sherlock",
                        last_name: "Holmes",
                        email: "sh@example.com",
                        password: "123456", 
                        password_confirmation: "123456")

charles = User.create!(first_name: "Charles",
                       last_name: "Darwin",
                       email: "cd@example.com",
                       password: "123456", 
                       password_confirmation: "123456")

tony = User.create!(first_name: "Tony",
                    last_name: "Stark",
                    email: "ts@example.com",
                    password: "123456", 
                    password_confirmation: "123456")

#Posts
post_1 = Post.create!(body: "Hello World!", user_id: sherlock.id)
post_2 = Post.create!(body: "FooBar.", user_id: charles.id)
post_3 = Post.create!(body: "こんにちは", user_id: tony.id)

#Comments
Comment.create!(body: "Great Post!", post_id: post_2.id, user_id: sherlock.id)
Comment.create!(body: "Holy Cow!", post_id: post_3.id, user_id: charles.id)

#Likes
Like.create!(user_id: sherlock.id, post_id: post_3.id)
Like.create!(user_id: tony.id, post_id: post_1.id)
Like.create!(user_id: charles.id, post_id: post_1.id)

#Friendships
Friendship.create!(friend_one_id: sherlock.id, friend_two_id: charles.id)
Friendship.create!(friend_one_id: charles.id, friend_two_id: tony.id)

#Friend Requests
FriendRequest.create!(sending_user_id: sherlock.id, receiving_user_id: tony.id)