# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Users
david = User.new(first_name: "David",
                        last_name: "Davidson",
                        email: "dd@example.com",
                        password: "123456", 
                        password_confirmation: "123456")
david.skip_confirmation!
david.save!

emma = User.new(first_name: "Emma",
                       last_name: "Emmason",
                       email: "ee@example.com",
                       password: "123456", 
                       password_confirmation: "123456")
emma.skip_confirmation!
emma.save!

amelia = User.new(first_name: "Amelia",
                    last_name: "Ameliason",
                    email: "aa@example.com",
                    password: "123456", 
                    password_confirmation: "123456")
amelia.skip_confirmation!
amelia.save!

#Posts
post_1 = Post.create!(body: "Hello World!", user_id: david.id)
post_2 = Post.create!(body: "Ut vitae arcu dapibus, blandit elit id, sollicitudin risus. Aenean accumsan ultricies ex sit amet auctor. Aenean scelerisque, lectus ut tincidunt tincidunt, ex dui vestibulum enim, id ullamcorper risus sapien vitae massa.", user_id: amelia.id)
post_3 = Post.create!(body: "Etiam placerat sem vitae est iaculis, vitae gravida erat pretium. Nunc bibendum, magna vel rhoncus elementum, nibh velit interdum arcu, sed vulputate ipsum mauris non dui.", user_id: emma.id)

#ActiveStorage Profile Picture
david.profile_picture.attach(io: File.open('db/seed_images/david.jpg'), filename: 'david.jpg', content_type: 'image/jpg')
emma.profile_picture.attach(io: File.open('db/seed_images/emma.jpg'), filename: 'emma.jpg', content_type: 'image/jpg')

#Comments
Comment.create!(body: "Great Post!", post_id: post_2.id, user_id: david.id)
Comment.create!(body: "Etiam ultrices venenatis semper. Suspendisse mauris eros, blandit vitae ligula eleifend, rutrum pretium risus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.", post_id: post_3.id, user_id: amelia.id)

#Likes
Like.create!(user_id: david.id, post_id: post_3.id)
Like.create!(user_id: emma.id, post_id: post_1.id)
Like.create!(user_id: amelia.id, post_id: post_1.id)

#Friendships
Friendship.create!(friend_one_id: david.id, friend_two_id: amelia.id)
Friendship.create!(friend_one_id: amelia.id, friend_two_id: emma.id)

#Friend Requests
FriendRequest.create!(sending_user_id: david.id, receiving_user_id: emma.id)