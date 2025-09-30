class TicketsController < ApplicationController
  def new
    @ticket = Ticket.new
  end
def create
  @ticket = Ticket.new(ticket_params)
  if @ticket.save
    redirect_to new_ticket_path, notice: "Ticket created successfully!"
  else
    render :new
  end
end

  def show
    @ticket = Ticket.find(params[:id])
  end

  private

  def ticket_params
    params.require(:ticket).permit(:company_name, :customer_name, :customer_number, :issue, :created_date)
  end
end
