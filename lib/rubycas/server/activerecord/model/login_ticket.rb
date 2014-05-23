require 'rubycas/server/activerecord/model/ticket'
require 'rubycas/server/activerecord/model/consumable'

module RubyCAS::Server::Core::Tickets
  class LoginTicket < ActiveRecord::Base
    include RubyCAS::Server::Core::Ticket
    #include RubyCAS::Server::Core::Consumable


    validates :ticket, :client_hostname, presence: true

    def expired?(max_lifetime)
      lifetime = Time.now.to_i - created_at.to_time.to_i
      lifetime > max_lifetime
    end

    def consumed?
      consumed.nil? ? false : true
    end

    def consume!
      self.consumed = DateTime.now
    end
  end
end
