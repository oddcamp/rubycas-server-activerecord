require 'rubycas/server/activerecord/model/ticket'
require 'rubycas/server/activerecord/model/consumable'

module RubyCAS::Server::Core::Database::Model
  class ServiceTicket < ActiveRecord::Base
    include Ticket
    include Consumable

    has_one :proxy_granting_ticket
    belongs_to :ticket_granting_ticket

    validates :ticket, :service, :ticket_granting_ticket_id, presence: true

    def expired?(max_lifetime)
      lifetime = Time.now.to_i - created_at.to_time.to_i
      lifetime > max_lifetime
    end
    def consumed?
      consumed
    end

    def consume!
      consumed = true
      self.save
    end
  end
end
