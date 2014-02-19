require 'rubycas/server/activerecord/model/ticket'
#require 'rubycas/server/activerecord/model/consumable'

module RubyCAS::Server::Core::Tickets
  class TicketGrantingTicket < ActiveRecord::Base
    include RubyCAS::Server::Core::Ticket
    #include RubyCAS::Server::Core::Consumable
    has_many :service_tickets, dependent: :destroy

    validates :ticket, :username, presence: true

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

    def self.cleanup(max_lifetime)
      transaction do
        conditions = ["created_at < ?", Time.now - max_lifetime]
        expired_tickets_count = count(:conditions => conditions)

        $LOG.debug("Destroying #{expired_tickets_count} expired #{self.name.demodulize}"+
          "#{'s' if expired_tickets_count > 1}.") if expired_tickets_count > 0

        destroy_all(conditions)
      end
    end
  end
end
