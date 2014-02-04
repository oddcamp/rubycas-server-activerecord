class Ticket < ActiveRecord::Base
  validates :ticket, :service, :client_hostname, :username, :another_type, presence: true
end
