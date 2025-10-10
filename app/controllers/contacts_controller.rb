class ContactsController < ApplicationController
def new
  @contact = Contact.new
  @company = Company.find_by(id: params[:company_id])
  @contact.company = @company if @company
end


end
