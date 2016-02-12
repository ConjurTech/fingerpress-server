class AddPermanentAttributesToPaymentRecordTimeLogs < ActiveRecord::Migration
  def change
    add_column :payment_record_time_logs, :workday, :boolean, default: false
    add_column :payment_record_time_logs, :public_holiday, :boolean, default: false
    add_column :payment_record_time_logs, :public_holiday_name, :string
    add_column :payment_record_time_logs, :ot_hours, :float, default: 0.0
  end
end
