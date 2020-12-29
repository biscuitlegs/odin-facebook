#Users
david = User.new(first_name: "David",
                        last_name: "Jones",
                        email: "david@example.com",
                        password: "password1", 
                        password_confirmation: "password1")
david.skip_confirmation!
david.save!

emma = User.new(first_name: "Emma",
                       last_name: "Doe",
                       email: "emma@example.com",
                       password: "password1", 
                       password_confirmation: "password1")
emma.skip_confirmation!
emma.save!

amelia = User.new(first_name: "Amelia",
                    last_name: "Wright",
                    email: "amelia@example.com",
                    password: "password1", 
                    password_confirmation: "password1")
amelia.skip_confirmation!
amelia.save!

mark = User.new(first_name: "Mark",
    last_name: "Wright",
    email: "mark@example.com",
    password: "password1", 
    password_confirmation: "password1")
mark.skip_confirmation!
mark.save!

kevin = User.new(first_name: "Kevin",
    last_name: "Holmes",
    email: "kevin@example.com",
    password: "password1", 
    password_confirmation: "password1")
kevin.skip_confirmation!
kevin.save!

#Posts
post_1 = Post.create!(body: "Proin quis felis eget purus tincidunt malesuada. Etiam quis est placerat, fermentum elit ac, tempus velit. Praesent nisi enim, pulvinar id dictum vitae, sollicitudin vitae elit.", user_id: david.id, created_at: Time.now - 20000)
post_2 = Post.create!(body: "Ut vitae arcu dapibus, blandit elit id, sollicitudin risus.", user_id: amelia.id, created_at: Time.now - 90000)
post_3 = Post.create!(body: "Duis ut mollis tortor. Praesent libero leo, porta eu finibus a, interdum et dolor. Cras rhoncus arcu quis cursus sagittis. Suspendisse ultrices nibh ante, id dignissim leo faucibus a. Vivamus sed rutrum elit, in pellentesque quam.", user_id: emma.id, created_at: Time.now - 300000)
post_4 = Post.create!(body: "Duis ut mollis tortor. Praesent libero leo, porta eu finibus a, interdum et dolor. Cras rhoncus arcu quis cursus sagittis. Suspendisse ultrices nibh ante, id dignissim leo faucibus a. Vivamus sed rutrum elit, in pellentesque quam.", user_id: mark.id, created_at: Time.now - 500000)
post_5 = Post.create!(body: "Duis ut mollis tortor. Praesent libero leo, porta eu finibus a, interdum et dolor. Cras rhoncus arcu quis cursus sagittis. Suspendisse ultrices nibh ante, id dignissim leo faucibus a. Vivamus sed rutrum elit, in pellentesque quam.", user_id: kevin.id, created_at: Time.now - 600000)

#ActiveStorage Post Picture
post_2.image.attach(io: File.open('db/seed_images/mountains.jpg'), filename: 'mountains.jpg', content_type: 'image/jpg')
post_4.image.attach(io: File.open('db/seed_images/moon.jpg'), filename: 'moon.jpg', content_type: 'image/jpg')

#ActiveStorage Profile Picture
david.profile_picture.attach(io: File.open('db/seed_images/david.jpg'), filename: 'david.jpg', content_type: 'image/jpg')
emma.profile_picture.attach(io: File.open('db/seed_images/emma.jpg'), filename: 'emma.jpg', content_type: 'image/jpg')
mark.profile_picture.attach(io: File.open('db/seed_images/mark.jpg'), filename: 'mark.jpg', content_type: 'image/jpg')
kevin.profile_picture.attach(io: File.open('db/seed_images/kevin.jpg'), filename: 'kevin.jpg', content_type: 'image/jpg')
amelia.profile_picture.attach(io: File.open('db/seed_images/amelia.jpg'), filename: 'amelia.jpg', content_type: 'image/jpg')

#Comments
Comment.create!(body: "Nulla rutrum justo augue. Sed molestie malesuada nisi, quis egestas sem accumsan sed. Duis dapibus mattis nibh at sollicitudin. Phasellus vitae.", post_id: post_2.id, user_id: david.id, created_at: Time.now - 3000)
Comment.create!(body: "Donec eget fringilla lacus. Sed malesuada elit in diam vulputate, vulputate malesuada sapien sodales. Vivamus malesuada eu est convallis dictum.", post_id: post_3.id, user_id: amelia.id, created_at: Time.now - 3000)
Comment.create!(body: "Etiam ultrices venenatis semper.", post_id: post_3.id, user_id: kevin.id, created_at: Time.now - 30000)
Comment.create!(body: "Quisque enim lectus, laoreet eget massa eget, egestas ultricies tellus.", post_id: post_3.id, user_id: mark.id)
Comment.create!(body: "Sed pharetra ultrices posuere. Duis odio magna, iaculis et auctor at, fermentum vitae lorem.", post_id: post_5.id, user_id: emma.id, created_at: Time.now - 400000)

#Likes
Like.create!(user_id: david.id, post_id: post_3.id)
Like.create!(user_id: emma.id, post_id: post_1.id)
Like.create!(user_id: amelia.id, post_id: post_1.id)
Like.create!(user_id: kevin.id, post_id: post_1.id)
Like.create!(user_id: mark.id, post_id: post_1.id)
Like.create!(user_id: amelia.id, post_id: post_2.id)
Like.create!(user_id: amelia.id, post_id: post_3.id)

#Friendships
Friendship.create!(friend_one_id: david.id, friend_two_id: amelia.id)
Friendship.create!(friend_one_id: amelia.id, friend_two_id: emma.id)
Friendship.create!(friend_one_id: amelia.id, friend_two_id: kevin.id)
Friendship.create!(friend_one_id: amelia.id, friend_two_id: mark.id)
Friendship.create!(friend_one_id: mark.id, friend_two_id: kevin.id)

#Friend Requests
FriendRequest.create!(sending_user_id: david.id, receiving_user_id: emma.id)
FriendRequest.create!(sending_user_id: mark.id, receiving_user_id: david.id)
FriendRequest.create!(sending_user_id: david.id, receiving_user_id: kevin.id)
