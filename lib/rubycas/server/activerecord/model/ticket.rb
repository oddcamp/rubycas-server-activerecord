class Ticket < ActiveRecord::Base
  validates :ticket, :service, :client_hostname, :username, :type, presence: true
end
