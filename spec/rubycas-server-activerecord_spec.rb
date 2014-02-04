require "spec_helper"

describe RubyCAS::Server::Core::ActiveRecord do

  before(:all) do
    ActiveRecord::Base.establish_connection(
      adapter: "sqlite3",
      database: ":memory:"
    )
    ActiveRecord::Migrator.migrate('db/migrate')
  end

  describe "Load schema" do

    it 'Validate number of models' do
      pending('Validate number of models')
    end

    it 'Validate Ticket Model' do
      pending('Validate Ticket Model')
    end

    it 'Validate ServiceTicket Model' do
      pending('Validate ServiceTicket Model')
    end

    it 'Validate ProxyTicket Model' do
      pending('Validate ProxyTicket Model')
    end

    it 'Validate LoginTicket Model' do
      pending('Validate LoginTicket Model')
    end

    it 'Validate ProxyGrantingTicket Model' do
      pending('Validate ProxyGrantingTicket Model')
    end

    it 'Validate TicketGrantingTicket Model' do
      pending('Validate TicketGrantingTicket Model')
    end

  end
end
