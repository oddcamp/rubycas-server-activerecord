class TicketGrantingTicket < ActiveRecord::Base
  has_many :service_tickets

  validates :ticket, :client_hostname, :username, presence: true
end
