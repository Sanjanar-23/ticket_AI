class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.references :company, null: false, foreign_key: true
      t.string :contact_person
      t.string :designation
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
