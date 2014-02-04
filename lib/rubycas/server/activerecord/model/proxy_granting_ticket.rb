class ProxyGrantingTicket < ActiveRecord::Base
  validates :ticket, :client_hostname, :iou, presence: true
end
