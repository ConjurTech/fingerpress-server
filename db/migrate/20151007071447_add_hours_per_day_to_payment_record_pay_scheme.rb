class AddHoursPerDayToPaymentRecordPayScheme < ActiveRecord::Migration
  def change
    add_column :payment_record_pay_schemes, :hours_per_day, :float
  end
end
