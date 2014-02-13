require 'rubycas/server/activerecord/model/ticket'
require 'rubycas/server/activerecord/model/consumable'

module RubyCAS::Server::Core::ActiveRecord::Model
  class LoginTicket < ActiveRecord::Base
    include Ticket
    include Consumable


    validates :ticket, :client_hostname, presence: true
  end
end
