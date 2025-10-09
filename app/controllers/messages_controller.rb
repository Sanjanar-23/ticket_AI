
class MessagesController < ApplicationController

  def index
    @messages = Message.order(created_at: :asc)
  end

  def clear
    Message.delete_all
    redirect_to messages_path, notice: "Chat history cleared!"
  end


  def new
    @message = Message.new
  end
  # def create
  #   @message = Message.new(role: "user", content: params[:message][:content])

  #   if @message.save
  #     question = @message.content.downcase.strip

  #     total_tickets = Ticket.count
  #     issue_counts = Ticket.group(:issue).count
  #     issue_summary = issue_counts.map { |issue, c| "#{issue}: #{c}" }.join("\n")

  #     latest_ticket = Ticket.order(created_at: :desc).first
  #     latest_ticket_info = latest_ticket ? "#{latest_ticket.issue} by #{latest_ticket.customer_name} at #{latest_ticket.created_at}" : "No latest ticket available"

  #     context_lines = []
  #     context_lines << "Total tickets: #{total_tickets}"
  #     context_lines << "Ticket counts by issue: \n#{issue_summary}"
  #     context_lines << "Latest ticket: #{latest_ticket_info}"

  #     if question.include?("first customer")
  #       first_customer = Ticket.order(created_at: :asc).first&.customer_name || "none"
  #       context_lines << "First customer: #{first_customer}"
  #     end

  #     if question.match?(/companies? (start|begin) with s/)
  #       companies_s = Ticket.where("company_name ILIKE ?", "s%").pluck(:company_name).uniq.join(", ")
  #       context_lines << "Companies starting with 'S': #{companies_s}"
  #     end

  #     context_text = context_lines.join("\n\n")

  #     prompt = <<~PROMPT
  #       You are a helpful assistant answering questions about customer tickets.

  #       Here is some data from the ticket database:

  #       #{context_text}

  #       User question: #{question}

  #       Please answer accurately based on the data above.
  #     PROMPT

  #     chat = RubyLLM.chat
  #     system_prompt = "You are an expert assistant providing concise, accurate answers about tickets."

  #     response = chat.with_instructions(system_prompt).ask(prompt)

  #     Message.create(role: "assistant", content: response.content)

  #     redirect_to messages_path
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  def create
    @message = Message.new(role: "user", content: params[:message][:content])
    if @message.save
      question = @message.content.downcase.strip
      sql_query = get_sql_query(question)
      results = run_sql_query(sql_query)

      chat = RubyLLM.chat
      system_prompt = "You are an expert assistant providing concise, accurate answers about tickets. Use the SQL query results to answer the user's question."
      user_prompt = "User question: #{question}\nSQL Query: #{sql_query}\nSQL Results: #{results.inspect}\nPlease provide a concise answer based on the SQL results."
      response = chat.with_instructions(system_prompt).ask(user_prompt)
      Message.create(role: "assistant", content: response.content)
      redirect_to messages_path
    else
      raise
      render :new, status: :unprocessable_entity
    end

  end

  private

  def get_sql_query(question)
    chat = RubyLLM.chat

    sql_generation = "Generate a MySQL query based on the table structure: %{table_structure}. Support queries involving multiple tables where applicable (e.g., grouping users by department). Only return the SQL query as plain text with no formatting, explanations, or markdown. Can make it as case insensitive."

    table_names = ActiveRecord::Base.connection.tables
    table_structure_details = get_table_structure(table_names.join(", "))
    user_prompt = "#{sql_generation}\nTable Structure: #{table_structure_details}\nUser question: #{question}"

    system_prompt = "You are an expert SQL generator. Only return the SQL query as plain text with no formatting, explanations, or markdown."
    response = chat.with_instructions(system_prompt).ask(user_prompt)
    return response.content
  end

  def get_table_structure(table_names)
    table_names.split(",").map(&:strip).map do |table_name|
      columns = ActiveRecord::Base.connection.columns(table_name).map(&:name).join(", ")
      "#{table_name} (#{columns})"
    end.join("\n")
  end

  def run_sql_query(sql_query)
    results = ActiveRecord::Base.connection.execute(sql_query)
    results.to_a
  end


end
