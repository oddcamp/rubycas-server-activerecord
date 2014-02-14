require 'rubycas/server/activerecord/model/ticket'
require 'rubycas/server/activerecord/model/consumable'

module RubyCAS::Server::Core::Tickets
  class ProxyTicket < ActiveRecord::Base
    belongs_to :proxy_granting_ticket

  end
end
