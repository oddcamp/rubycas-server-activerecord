class LoginTicket < ActiveRecord::Base
  validates :ticket, :client_hostname, presence: true
end
