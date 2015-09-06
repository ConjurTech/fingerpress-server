class AddStartDateEndDateToPaymentRecord < ActiveRecord::Migration
  def change
    add_column :payment_records, :start_date, :datetime
    add_column :payment_records, :end_date, :datetime
  end
end
