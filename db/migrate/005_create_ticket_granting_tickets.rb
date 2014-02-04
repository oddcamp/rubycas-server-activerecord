class CreateTicketGrantingTickets < ActiveRecord::Migration
  def change
    create_table :ticket_granting_tickets do |t|
      t.string :ticket
      t.string :client_hostname
      t.string :username
      t.text :extra_attriutes #ONLY postgresql supports JSON

      t.timestamps
    end
  end
end
