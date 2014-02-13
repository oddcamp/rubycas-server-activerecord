require 'rubycas/server/activerecord/model/ticket'
require 'rubycas/server/activerecord/model/consumable'

module RubyCAS::Server::Core::Database::Model
  class ProxyGrantingTicket < ActiveRecord::Base
    belongs_to :service_ticket
    has_many :proxy_tickets

    validates :ticket, :client_hostname, :iou, presence: true
  end
end
