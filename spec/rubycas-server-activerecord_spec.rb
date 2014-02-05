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

  describe LoginTicket do
    before do
      @login_ticket = LoginTicket.new(
        ticket: "Example Ticket",
        consumed: Time.at(rand * Time.now.to_i),
        client_hostname: "Example Client",
      )
    end

    it "responds to properties" do
      expect(@login_ticket).to respond_to(:ticket)
      expect(@login_ticket).to respond_to(:consumed)
      expect(@login_ticket).to respond_to(:client_hostname)

      expect(@login_ticket).to be_valid
    end

    describe "when ticket is not present" do
      before { @login_ticket.ticket = "  " }
      it { expect(@login_ticket).not_to be_valid }
    end

    describe "when client_hostname is not present" do
      before { @login_ticket.client_hostname = "  " }
      it { expect(@login_ticket).not_to be_valid }
    end
  end

  describe ProxyGrantingTicket do
    before do
      @proxy_granting_ticket = ProxyGrantingTicket.new(
        ticket: "Example Ticket",
        client_hostname: "Example Client",
        iou: "Example IOU"
      )
    end

    it "responds to properties" do
      expect(@proxy_granting_ticket).to respond_to(:ticket)
      expect(@proxy_granting_ticket).to respond_to(:client_hostname)
      expect(@proxy_granting_ticket).to respond_to(:iou)

      expect(@proxy_granting_ticket).to be_valid
    end

    describe "when ticket is not present" do
      before { @proxy_granting_ticket.ticket = "  " }
      it { expect(@proxy_granting_ticket).not_to be_valid }
    end

    describe "when client_hostname is not present" do
      before { @proxy_granting_ticket.client_hostname = "  " }
      it { expect(@proxy_granting_ticket).not_to be_valid }
    end

    describe "when iou is not present" do
      before { @proxy_granting_ticket.iou = "  " }
      it { expect(@proxy_granting_ticket).not_to be_valid }
    end
  end


  describe TicketGrantingTicket do
    before do
      @ticket_granting_ticket = TicketGrantingTicket.new(
        ticket: "Example Ticket",
        client_hostname: "Example Client",
        username: "Example Username",
      )
    end

    it "responds to properties" do
      expect(@ticket_granting_ticket).to respond_to(:ticket)
      expect(@ticket_granting_ticket).to respond_to(:client_hostname)
      expect(@ticket_granting_ticket).to respond_to(:username)

      expect(@ticket_granting_ticket).to be_valid
    end

    describe "when ticket is not present" do
      before { @ticket_granting_ticket.ticket = "  " }
      it { expect(@ticket_granting_ticket).not_to be_valid }
    end

    describe "when client_hostname is not present" do
      before { @ticket_granting_ticket.client_hostname = "  " }
      it { expect(@ticket_granting_ticket).not_to be_valid }
    end

    describe "when username is not present" do
      before { @ticket_granting_ticket.username = "  " }
      it { expect(@ticket_granting_ticket).not_to be_valid }
    end
  end

  describe ServiceTicket do
    before do
      @ticket_granting_ticket = TicketGrantingTicket.new(
        ticket: "Example Ticket",
        client_hostname: "Example Client",
        username: "Example Username",
      )
      @ticket_granting_ticket.save!

      @service_ticket = @ticket_granting_ticket.service_tickets.build(
        ticket: "Example Ticket",
        service: "Example Service",
        consumed: Time.at(rand * Time.now.to_i)
      )
    end

    subject { @service_ticket }

    it { expect(@service_ticket).to respond_to(:ticket) }
    it { expect(@service_ticket).to respond_to(:service) }
    it { expect(@service_ticket).to respond_to(:consumed) }
    it { expect(@service_ticket).to respond_to(:ticket_granting_ticket_id) }

    its(:ticket_granting_ticket) { should eq(@ticket_granting_ticket) }

    describe "with the initialization" do
      it { expect(@ticket_granting_ticket).to be_valid }
      it { expect(@service_ticket).to be_valid }
    end

    describe "with ticket_granting_ticket_id not present" do
      before { @service_ticket.ticket_granting_ticket_id = nil }
      it { expect(@service_ticket).not_to be_valid }
    end
  end



end
