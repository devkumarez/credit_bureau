class CreateApplicants < ActiveRecord::Migration[6.0]
  def change
    create_table :applicants do |t|
      t.string :email
      t.string :pan_card
      t.integer :aadhar_number
      t.integer :bank_account_number
      t.string :bank_account_ifsc
      t.decimal :monthly_recurring_inflow
      t.decimal :monthly_recurring_outflow
      t.integer :recommendation

      t.timestamps
    end
  end
end
