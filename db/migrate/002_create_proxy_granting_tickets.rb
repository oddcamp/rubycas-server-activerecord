class CreateProxyGrantingTickets < ActiveRecord::Migration
  def change
    create_table :proxy_granting_tickets do |t|
      t.string :ticket
      t.string :client_hostname
      t.string :iou

      t.timestamps
    end
  end
end
