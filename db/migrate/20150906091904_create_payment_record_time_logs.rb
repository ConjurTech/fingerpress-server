class CreatePaymentRecordTimeLogs < ActiveRecord::Migration
  def change
    create_table :payment_record_time_logs do |t|
      t.datetime :date_time_in
      t.datetime :date_time_out
      t.references :payment_record_pay_scheme, index: true, foreign_key: true
      t.belongs_to :payment_record, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
