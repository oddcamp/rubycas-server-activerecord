require 'rubycas/server/activerecord/model/ticket'
require 'rubycas/server/activerecord/model/consumable'

module RubyCAS::Server::Core::Tickets
  class LoginTicket < ActiveRecord::Base
    include Ticket
    include Consumable


    validates :ticket, :client_hostname, presence: true

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
