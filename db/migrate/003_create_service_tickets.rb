class CreateServiceTickets < ActiveRecord::Migration
  def change
    create_table :service_tickets do |t|
      t.string :ticket
      t.text :service
      t.datetime :consumed
      t.string :username
      t.string :client_hostname

      t.belongs_to :ticket_granting_ticket

      t.timestamps
    end
  end
end
