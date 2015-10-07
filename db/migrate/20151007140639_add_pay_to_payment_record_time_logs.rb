class AddPayToPaymentRecordTimeLogs < ActiveRecord::Migration
  def change
    add_column :payment_record_time_logs, :pay, :float
  end
end
