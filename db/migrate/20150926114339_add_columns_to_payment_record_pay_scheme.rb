class AddColumnsToPaymentRecordPayScheme < ActiveRecord::Migration
  def change
    add_column :payment_record_pay_schemes, :ot_multiplier, :float
    add_column :payment_record_pay_schemes, :ot_time_range_start, :time
    add_column :payment_record_pay_schemes, :ot_time_range_end, :time
    add_column :payment_record_pay_schemes, :public_holiday_multiplier, :float
    add_column :payment_record_pay_schemes, :pay_weekend, :float
    add_column :payment_record_pay_schemes, :weekend_multiplier, :float
    add_reference :payment_record_pay_schemes, :ot_type, index: true, foreign_key: true
    add_reference :payment_record_pay_schemes, :public_holiday_type, index: true, foreign_key: true
    add_reference :payment_record_pay_schemes, :weekend_type, index: true, foreign_key: true
  end
end
