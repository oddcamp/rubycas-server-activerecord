class TicketGrantingTicket < ActiveRecord::Base
  validates :ticket, :client_hostname, :username, presence: true
end
