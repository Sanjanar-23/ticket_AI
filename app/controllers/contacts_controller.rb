class ContactsController < ApplicationController
  def new
    @contact = Contact.new(company_id: params[:company_id])
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
        redirect_to company_path(@contact.company), notice: "Contact created successfully."
    else
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:company_id, :contact_person, :designation, :phone, :email)
  end
end
