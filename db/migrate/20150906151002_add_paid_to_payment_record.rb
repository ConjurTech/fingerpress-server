class AddPaidToPaymentRecord < ActiveRecord::Migration
  def change
    add_column :payment_records, :paid, :boolean, default: false
  end
end
