class AddIndexes < ActiveRecord::Migration
  def change
    add_index(:login_tickets, :ticket)
    add_index(:proxy_granting_tickets, :ticket)
    add_index(:service_tickets, :ticket)
    add_index(:ticket_granting_tickets, :ticket)
  end
end
