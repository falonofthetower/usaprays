# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Added by Refinery CMS Pages extension
Refinery::Pages::Engine.load_seed

# Added by Refinery CMS Justices extension
Refinery::Justices::Engine.load_seed

# Added by Refinery CMS Executives extension
Refinery::Executives::Engine.load_seed

admin = Refinery::User.new
admin.username = 'admin'
admin.email = 'admin@admin.com'
admin.password = 'admin'
admin.password_confirmation = 'admin'

if admin.create_first
  puts "Creating first user with username:  admin, password: admin.  Change this password!"
else
  puts "Failed to create first user"
end
