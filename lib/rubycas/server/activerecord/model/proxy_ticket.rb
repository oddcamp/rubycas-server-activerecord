require 'rubycas/server/activerecord/model/ticket'
require 'rubycas/server/activerecord/model/consumable'

module RubyCAS::Server::Core::Database::Model
  class ProxyTicket < ActiveRecord::Base
    belongs_to :proxy_granting_ticket

  end
end
