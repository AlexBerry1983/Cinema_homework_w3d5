class Customer

  attr_reader :id 
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name, funds)
          VALUES ('#{@name}', #{@funds})
          RETURNING id;"
    new_customer = SqlRunner.run(sql).first
    @id = new_customer['id'].to_i
  end

  def update
    sql = "UPDATE customers
          SET (name, funds) =
          ('#{@name}', #{@funds})
          WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def delete
    sql = "DELETE FROM customers WHERE id = '#{@id}'"
    SqlRunner.run(sql)
  end

  def films
    sql = "SELECT films.* FROM films
          INNER JOIN tickets ON tickets.film_id = films.id
          WHERE customer_id = #{@id}"
    return Film.get_many(sql)
  end
  
  def buy_ticket(ticket_number)
     film = Film.find_id(ticket_number.film_id)
     @funds -= film.price
     update
  end

  def Customer.get_many(sql)
    customers = SqlRunner.run(sql)
    result = customers.map { |customer| Customer.new(customer) }
    return result
  end

  def Customer.delete_all
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def Customer.all
    sql = "SELECT * FROM customers"
    customer_array = SqlRunner.run(sql)
    customers_rb = customer_array.map { |customer| Customer.new(customer) }
    return customers_rb
  end

  def Customer.find_id(sought_id)
    sql = "SELECT * FROM customers WHERE id = #{sought_id}"
    found_customer = SqlRunner.run(sql)
    return Customer.new(found_customer.first)
  end
end