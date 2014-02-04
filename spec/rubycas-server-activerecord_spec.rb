require "spec_helper"

describe RubyCAS::Server::Core::ActiveRecord do

  before(:all) do
    ActiveRecord::Base.establish_connection(
      adapter: "sqlite3",
      database: ":memory:"
    )
    ActiveRecord::Migrator.migrate('db/migrate')
  end


  describe Ticket do
    before do
      @ticket = Ticket.new(
        ticket: "Example Ticket",
        service: "Example Service",
        client_hostname: "Example Client",
        username: "Example Username",
        # FIX this
        another_type: "Example Type"
      )
    end

    it "responds to properties" do
      expect(@ticket).to respond_to(:ticket)
      expect(@ticket).to respond_to(:service)
      expect(@ticket).to respond_to(:client_hostname)
      expect(@ticket).to respond_to(:username)
      expect(@ticket).to respond_to(:another_type)

      expect(@ticket).to be_valid
    end

    describe "when ticket is not present" do
      before { @ticket.ticket = "  " }
      it { expect(@ticket).not_to be_valid }
    end

    describe "when service is not present" do
      before { @ticket.service = "  " }
      it { expect(@ticket).not_to be_valid }
    end

    describe "when client_hostname is not present" do
      before { @ticket.client_hostname = "  " }
      it { expect(@ticket).not_to be_valid }
    end

    describe "when username is not present" do
      before { @ticket.username = "  " }
      it { expect(@ticket).not_to be_valid }
    end

    #FIX this
    describe "when another_type is not present" do
      before { @ticket.another_type = "  " }
      it { expect(@ticket).not_to be_valid }
    end
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
