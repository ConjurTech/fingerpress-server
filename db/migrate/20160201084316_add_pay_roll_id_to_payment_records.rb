class AddPayRollIdToPaymentRecords < ActiveRecord::Migration
  def change
    add_reference :payment_records, :pay_roll, index: true, foreign_key: true
  end
end
