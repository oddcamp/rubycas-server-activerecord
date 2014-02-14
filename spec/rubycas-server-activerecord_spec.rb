require "spec_helper"

include RubyCAS::Server::Core::Tickets

describe RubyCAS::Server::Core::Tickets do

  before(:all) do
    ActiveRecord::Base.establish_connection(
      adapter: "sqlite3",
      database: ":memory:"
    )
    ActiveRecord::Migrator.migrate('db/migrate')
  end
=begin
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

    it "is invalid without :ticket" do
      @ticket.ticket = "  "
      expect(@ticket).not_to be_valid
    end

    it "is invalid without service" do
      @ticket.service = "  "
      expect(@ticket).not_to be_valid
    end

    it "is invalid without client_hostname" do
      @ticket.client_hostname = "  "
      expect(@ticket).not_to be_valid
    end

    it "is invalid without username" do
      @ticket.username = "  "
      expect(@ticket).not_to be_valid
    end

    #FIX this
    it "is invalid without another_type" do
      @ticket.another_type = "  "
      expect(@ticket).not_to be_valid
    end
  end
=end
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
      expect(@login_ticket).to respond_to(:consume!)

      expect(@login_ticket).to be_valid
    end

    it "is invalid whithout ticket" do
      @login_ticket.ticket = "  "
      expect(@login_ticket).not_to be_valid
    end

    it "is invalid without client_hostname" do
      @login_ticket.client_hostname = "  "
      expect(@login_ticket).not_to be_valid
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

    it "is invalid without ticket" do
      @proxy_granting_ticket.ticket = "  "
      expect(@proxy_granting_ticket).not_to be_valid
    end

    it "is invalid without client_hostname" do
      @proxy_granting_ticket.client_hostname = "  "
      expect(@proxy_granting_ticket).not_to be_valid
    end

    it "is invalid without iou" do
      @proxy_granting_ticket.iou = "  "
      expect(@proxy_granting_ticket).not_to be_valid
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

    it "is invalid without ticket" do
      @ticket_granting_ticket.ticket = "  "
      expect(@ticket_granting_ticket).not_to be_valid
    end

    it "is invalid without client_hostname" do
      @ticket_granting_ticket.client_hostname = "  "
      expect(@ticket_granting_ticket).not_to be_valid
    end

    it "is invalid without username" do
      @ticket_granting_ticket.username = "  "
      expect(@ticket_granting_ticket).not_to be_valid
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

    subject {@service_ticket}
    its(:ticket_granting_ticket) { should eq(@ticket_granting_ticket) }

    it "responds to properties" do
      expect(@service_ticket).to respond_to(:ticket)
      expect(@service_ticket).to respond_to(:service)
      expect(@service_ticket).to respond_to(:consumed)
      expect(@service_ticket).to respond_to(:ticket_granting_ticket_id)
    end

    it "is invalid without :ticket" do
      @service_ticket.ticket = nil
      expect(@service_ticket).not_to be_valid
    end

    it "is invalid without :service" do
      @service_ticket.service = nil
      expect(@service_ticket).not_to be_valid
    end

    it "is invalid without foreign key" do
      @service_ticket.ticket_granting_ticket_id = nil
      expect(@service_ticket).not_to be_valid
    end
  end

end
