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
      expect(@ticket_granting_ticket).to respond_to(:remember_me)

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

    it "is valid without remember_me" do
      expect(@ticket_granting_ticket).to be_valid
    end

    it "remember_me gets the default value false" do
      @ticket_granting_ticket = TicketGrantingTicket.new(
        ticket: "Example Ticket",
        client_hostname: "Example Client",
        username: "Example Username",
      )
      @ticket_granting_ticket.save!
      expect(@ticket_granting_ticket.remember_me).to be_false
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
        username: "Example username",
        client_hostname: "Example client hostname"
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

    it "is not consumed at first" do
      expect(@service_ticket.consumed?).to be_false
    end
require 'rubycas/server/activerecord/model/ticket'
#require 'rubycas/server/activerecord/model/consumable'

module RubyCAS::Server::Core::Tickets
  class ServiceTicket < ActiveRecord::Base
    include RubyCAS::Server::Core::Ticket
    #include RubyCAS::Server::Core::Consumable

    has_one :proxy_granting_ticket
    belongs_to :ticket_granting_ticket

    validates :ticket, :service, :ticket_granting_ticket_id, presence: true

    def expired?(max_lifetime)
      lifetime = Time.now.to_i - created_at.to_time.to_i
      lifetime > max_lifetime
    end

    def consumed?
      consumed.nil? ? false : true
    end

    def consume!
      self.consumed = DateTime.now
    end
  end
end
    context "Service ticket consumption" do
      it "when consumed #consumed? returns true" do
        @service_ticket.consume!
        expect(@service_ticket.consumed?).to eq true
        expect(@service_ticket.consumed.to_s).to eq DateTime.now.to_s
      end
    end
  end

end
