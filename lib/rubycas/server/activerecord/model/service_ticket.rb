require 'rubycas/server/activerecord/model/ticket'
require 'rubycas/server/activerecord/model/consumable'

module RubyCAS::Server::Core::ActiveRecord::Model
  class ServiceTicket < ActiveRecord::Base
    include Ticket
    include Consumable

    has_one :proxy_granting_ticket
    belongs_to :ticket_granting_ticket

    validates :ticket, :service, :ticket_granting_ticket_id, presence: true
  end
end
