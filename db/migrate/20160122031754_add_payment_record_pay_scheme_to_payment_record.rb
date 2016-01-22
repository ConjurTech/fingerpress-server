class AddPaymentRecordPaySchemeToPaymentRecord < ActiveRecord::Migration
  def change
    add_reference :payment_records, :payment_record_pay_scheme, index: true, foreign_key: true
  end
end
