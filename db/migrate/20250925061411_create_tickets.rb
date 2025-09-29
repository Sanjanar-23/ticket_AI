class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.string :company_name
      t.string :customer_name
      t.integer :customer_number
      t.text :issue
      t.date :created_date

      t.timestamps
    end
  end
end
