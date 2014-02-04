class CreateLoginTickets < ActiveRecord::Migration
  def change
    create_table :login_tickets do |t|
      t.string :ticket
      t.datetime :consumed
      t.string :client_hostname

      t.timestamps
    end
  end
end
