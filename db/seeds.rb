PASSWORD = 'supersecret'

Review.destroy_all
Product.destroy_all
User.destroy_all



super_user = User.create(
  first_name: 'Jon',
  last_name: 'Snow',
  email: 'js@winterfell.gov',
  password: PASSWORD,
  is_admin: true
)

10.times.each do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
    password: PASSWORD
  )
end
users = User.all

puts Cowsay.say("Created #{users.count} users", :tux)


1000.times do
  Product.create(
    title: Faker::Seinfeld.quote,
    description: Faker::HitchhikersGuideToTheGalaxy.quote,
    price: rand(1..1000),
    user: users.sample
  )
end

products = Product.all

puts Cowsay.say("Created #{Product.count} products", :ghostbusters)


products.each do |product|
  rand(1..5).times.each do
    Review.create(
      rating: rand(1..5),
      body: Faker::TheFreshPrinceOfBelAir.quote,
      product: product,
      user: users.sample,
      is_hidden: false
    )
  end
end

reviews = Review.all

puts Cowsay.say("Create #{reviews.count} reviews", :moose)

puts "Login as admin with #{super_user.email} and password of '#{PASSWORD}'!"
