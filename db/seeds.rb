if Rails.env.development?
  User.destroy_all

  [
    { email: "alice@example.com",   password: "password123", score: 150 },
    { email: "bob@example.com",     password: "password123", score: 120 },
    { email: "charlie@example.com", password: "password123", score: 90 },
    { email: "diana@example.com",   password: "password123", score: 60 },
    { email: "eve@example.com",     password: "password123", score: 30 }
  ].each do |attrs|
    User.create!(attrs)
  end

  puts "Seeded #{User.count} users."
end
