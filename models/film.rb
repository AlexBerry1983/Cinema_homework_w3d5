require_relative('../db/Sql_runner')
require_relative('./customer')
class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save
    sql = "INSERT INTO films (title, price)
          VALUES ('#{@title}', #{@price})
          RETURNING id;"
    new_film = SqlRunner.run(sql).first
    @id = new_film['id'].to_i
  end

  def update
    sql = "UPDATE films 
          SET (title, price)
          = ('#{@title}', #{@price})
          WHERE id = #{@id}"
    SqlRunner.run(sql) 
  end

  def delete
    sql = "DELETE FROM films WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def customers
    sql = "SELECT customers.* FROM customers
          INNER JOIN tickets ON tickets.customer_id = customers.id
          WHERE film_id = #{@id}"
    return Customer.get_many(sql)
  end

  def Film.find_id(sought_id)
    sql = "SELECT * FROM films WHERE id = #{sought_id}"
    found_film = SqlRunner.run(sql)
    return Film.new(found_film.first)
  end
  
  def Film.get_many(sql)
    films = SqlRunner.run(sql)
    result = films.map { |film| Film.new(film) }
    return result
  end

  def Film.all
    sql = "SELECT * FROM films"
    film_array_pg = SqlRunner.run(sql)
    film_rb = film_array_pg.map {|film| Film.new(film)}
    return film_rb
  end

  def Film.delete_all
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

end