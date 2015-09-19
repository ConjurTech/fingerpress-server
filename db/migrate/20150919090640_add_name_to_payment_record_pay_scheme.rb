class AddNameToPaymentRecordPayScheme < ActiveRecord::Migration
  def change
    add_column :payment_record_pay_schemes, :name, :string
  end
end
