
class MessagesController < ApplicationController

  def create
  @message = Message.new(role: "user", content: params[:message][:content])

  if @message.save
    question = @message.content.downcase.strip

    total_tickets = Ticket.count
    issue_counts = Ticket.group(:issue).count
    issue_summary = issue_counts.map { |issue, c| "#{issue}: #{c}" }.join("\n")

    latest_ticket = Ticket.order(created_at: :desc).first
    latest_ticket_info = latest_ticket ? "#{latest_ticket.issue} by #{latest_ticket.customer_name} at #{latest_ticket.created_at}" : "No latest ticket available"

    context_lines = []
    context_lines << "Total tickets: #{total_tickets}"
    context_lines << "Ticket counts by issue: \n#{issue_summary}"
    context_lines << "Latest ticket: #{latest_ticket_info}"

    if question.include?("first customer")
      first_customer = Ticket.order(created_at: :asc).first&.customer_name || "none"
      context_lines << "First customer: #{first_customer}"
    end

    if question.match?(/companies? (start|begin) with s/)
      companies_s = Ticket.where("company_name ILIKE ?", "s%").pluck(:company_name).uniq.join(", ")
      context_lines << "Companies starting with 'S': #{companies_s}"
    end

    context_text = context_lines.join("\n\n")

    prompt = <<~PROMPT
      You are a helpful assistant answering questions about customer tickets.

      Here is some data from the ticket database:

      #{context_text}

      User question: #{question}

      Please answer accurately based on the data above.
    PROMPT

    chat = RubyLLM.chat
    system_prompt = "You are an expert assistant providing concise, accurate answers about tickets."

    response = chat.with_instructions(system_prompt).ask(prompt)

    Message.create(role: "assistant", content: response.content)

    redirect_to messages_path
  else
    render :new, status: :unprocessable_entity
  end
end


end
