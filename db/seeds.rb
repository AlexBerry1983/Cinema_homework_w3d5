require_relative('../models/film')
require_relative('../models/customer')
require_relative('../models/ticket')
require_relative('../db/Sql_runner')

require('pry-byebug')

Ticket.delete_all
Customer.delete_all
Film.delete_all

film1 = Film.new({ 'title' => 'Alien Covenant', 'price' => 20 })
film2 = Film.new({ 'title' => 'Guardians of the Galaxy 2', 'price' => 15 })
film3 = Film.new({ 'title' => 'Kong: Skull Island', 'price' => 10 })

film1.save
film2.save
film3.save

customer1 = Customer.new({ 'name' => 'Ron', 'funds' => 500 })
customer2 = Customer.new({ 'name' => 'Champ', 'funds' => 100 })
customer3 = Customer.new({ 'name' => 'Brick', 'funds' => 50 })
customer4 = Customer.new({ 'name' => 'Brian', 'funds' => 200 })

customer1.save
customer2.save
customer3.save
customer4.save

ticket1 = Ticket.new({ 'film_id' => film1.id, 'customer_id' => customer1.id})
ticket2 = Ticket.new({ 'film_id' => film2.id, 'customer_id' => customer4.id})
ticket3 = Ticket.new({ 'film_id' => film3.id, 'customer_id' => customer1.id})
ticket4 = Ticket.new({ 'film_id' => film2.id, 'customer_id' => customer2.id})
ticket5 = Ticket.new({ 'film_id' => film3.id, 'customer_id' => customer3.id})

ticket1.save
ticket2.save
ticket3.save
ticket4.save
ticket5.save

binding.pry
nil