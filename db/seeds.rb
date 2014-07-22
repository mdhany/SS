# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#For Create Roles
['beginner', 'intermediate', 'expert', 'admin'].each do |role|
  Role.find_or_create_by name: role
end

#UserAdmins
lg = Login.create!(
    id: 1000,
    email: 'melvin.dani7@gmail.com',
    password: 'themaster007',
    password_confirmation: 'themaster007',
    username: 'mdhany',
    first_name: 'Melvin',
    last_name: 'Danis',
    identification: '22500631258',
    phone: '8492660666',
    country: 'República Dominicana',
    city: 'Santo Domingo',
    level_id: 3,
    account_type: 'Banco BHD',
    number_account: 12868740011
)
Manager.create!(
    email: 'melvin.dani7@gmail.com',
    password: 'themaster007',
    password_confirmation: 'themaster007',
)

lg.capacities.create!(
    name: 'intermediate',
    level_id: 2
)
lg.capacities.create!(
    name: 'avanced',
    level_id: 3
)

#Levels
Level.create!(
    name: 'Fila $25',
    amount: 25
)
Level.create!(
    name: 'Fila $75',
    amount: 75
)
Level.create!(
    name: 'Fila $125',
    amount: 125
)

#Turns
[1,2,3].each do |t|
  lg.turns.create!(
      id: 100+t,
      level_id: t
  )
end
