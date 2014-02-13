require 'rubycas/server/activerecord/model/ticket'
require 'rubycas/server/activerecord/model/consumable'

module RubyCAS::Server::Core::Database::Model
  class TicketGrantingTicket < ActiveRecord::Base
    include Ticket
    has_many :service_tickets

    validates :ticket, :client_hostname, :username, presence: true
  end
end
