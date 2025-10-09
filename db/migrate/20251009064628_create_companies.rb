class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :address_section
      t.string :area
      t.string :city
      t.string :state
      t.string :country
      t.string :website
      t.string :phone
      t.string :territory

      t.timestamps
    end
  end
end
