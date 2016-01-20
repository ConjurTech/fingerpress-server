class AddRemarksToPaymentRecordTimeLog < ActiveRecord::Migration
  def change
    add_column :payment_record_time_logs, :remarks, :string
  end
end
