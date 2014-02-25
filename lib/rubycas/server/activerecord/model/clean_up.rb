module RubyCAS::Server::Core::Tickets
  module CleanUp
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
