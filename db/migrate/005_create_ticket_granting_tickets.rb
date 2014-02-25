class CreateTicketGrantingTickets < ActiveRecord::Migration
  def change
    create_table :ticket_granting_tickets do |t|
      t.string :ticket
      t.string :client_hostname
      t.string :username
      t.boolean :remember_me, default: false
      t.text :extra_attributes #ONLY postgresql supports JSON

      t.timestamps
    end
  end
end
