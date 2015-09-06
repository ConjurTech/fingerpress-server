class AddPaymentRecordToTimeLog < ActiveRecord::Migration
  def change
    add_reference :time_logs, :payment_record, index: true, foreign_key: true
  end
end
