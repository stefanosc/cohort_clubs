require 'faker'

largemouth = Cohort.create(name: 'largemouth')

23.times do
  User.create(name: Faker::Name.first_name, email: Faker::Internet.email, cohort: largemouth )
end
