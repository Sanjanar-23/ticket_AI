class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @open_tickets_count = Ticket.where(status: 'open').count
  @closed_tickets_count = Ticket.where(status: 'closed').count

   @ticket_data = {
    "Open Tickets" => @open_tickets_count,
    "Closed Tickets" => @closed_tickets_count
  }
  end

  def view
  end

  def create_ticket
  end

  def index
  @open_tickets_count = Ticket.where(status: 'open').count
  @closed_tickets_count = Ticket.where(status: 'closed').count

  @ticket_status_counts = {
    "Open" => Ticket.where(status: 'open').count,
    "Closed" => Ticket.where(status: 'closed').count
  }
end


end
