class PagesController < ApplicationController
  #skip_before_action :authenticate_user!, only: [ :home ]

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

#   def index
#       @open_tickets_count = Ticket.where(status: 'open').count
#       @closed_tickets_count = Ticket.where(status: 'closed').count

#       raw_data = Ticket.group(:status).count

#   # Remove nil key and map keys for labels
#     filtered_data = raw_data.reject { |k, _| k.nil? }

#     @ticket_status_counts = {
#       "Open" => filtered_data["open"] || 0,
#       "Closed" => filtered_data["closed"] || 0
#     }

#     @open_tickets_count = @ticket_status_counts["Open"]
#     @closed_tickets_count = @ticket_status_counts["Closed"]
# end


def index
  raw_data = Ticket.where.not(status: nil).group(:status).count

  @ticket_status_counts = {
    "Open" => raw_data["open"] || 0,
    "Closed" => raw_data["closed"] || 0
  }


  @open_tickets_count = @ticket_status_counts["Open"]
  @closed_tickets_count = @ticket_status_counts["Closed"]


  # @open_tickets_count = Ticket.where(status: 'open').count
  #     @closed_tickets_count = Ticket.where(status: 'closed').count
end



end
