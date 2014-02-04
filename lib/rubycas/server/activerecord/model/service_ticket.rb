class ServiceTicket < ActiveRecord::Base
  has_one :proxy_granting_ticket
  belongs_to :ticket_granting_ticket
end
