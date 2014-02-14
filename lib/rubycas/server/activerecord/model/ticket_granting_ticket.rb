require 'rubycas/server/activerecord/model/ticket'
require 'rubycas/server/activerecord/model/consumable'

module RubyCAS::Server::Core::Tickets
  class TicketGrantingTicket < ActiveRecord::Base
    include Ticket
    has_many :service_tickets

    validates :ticket, :client_hostname, :username, presence: true

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
