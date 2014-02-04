class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :ticket
      t.text :service
      t.datetime :consumed
      t.string :client_hostname
      t.string :username
      t.string :another_type

      t.timestamps
    end
  end
end
