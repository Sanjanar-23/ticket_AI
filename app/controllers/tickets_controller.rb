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

  def index

      # @tickets = Ticket.order(created_at: :desc)
        @tickets = Ticket.all
          if params[:query].present?
          @tickets = @tickets.where("issue ILIKE ?", "%#{params[:query]}%")
        end

      # @tickets = @tickets.page(params[:page]).per(10) # <- This must be INSIDE the method
  end

def edit
  @ticket = Ticket.find(params[:id])
end

def update
  @ticket = Ticket.find(params[:id])
  if @ticket.update(ticket_params)
    redirect_to @ticket, notice: "Ticket updated successfully."
  else
    render :edit
  end
end

  private

  def ticket_params
    params.require(:ticket).permit(:company_name, :customer_name, :customer_number, :issue, :created_date, :status , :email)
  end
end
#  @tickets = Ticket.all
