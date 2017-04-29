require_relative('../db/Sql_runner')
require_relative('./customer')
require_relative('./film')

class Ticket

  attr_reader :id
  attr_accessor :film_id, :customer_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id'].to_i
    @customer_id = options['customer_id'].to_i
  end

  def save
    sql = "INSERT INTO tickets (film_id, customer_id)
          VALUES (#{@film_id}, #{@customer_id})
          RETURNING id;"
    ticket = SqlRunner.run(sql).first
    @id = ticket['id'].to_i
  end

  def delete
    sql = "DELETE FROM tickets WHERE id = '#{@id}'"
    SqlRunner.run(sql)
  end

  def Ticket.find_id(sought_id)
    sql = "SELECT * FROM tickets WHERE id = #{sought_id}"
    found_ticket = SqlRunner.run(sql)
    return Ticket.new(found_ticket.first) 
  end

  def Ticket.delete_all
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def Ticket.all
    sql = "SELECT * FROM tickets"
    ticket_array = SqlRunner.run(sql)
    tickets = ticket_array.map { |ticket| Ticket.new(ticket)}
    return tickets
  end

end