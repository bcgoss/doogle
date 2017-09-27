# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = User.new(email: 'admin@example.com', role: :admin, password: ENV['AdminPassword'], password_confirmation: ENV['AdminPassword'])
if admin.save
  puts 'Saved ' + admin.email
else
  puts admin.errors.full_messages.join('. ')
end