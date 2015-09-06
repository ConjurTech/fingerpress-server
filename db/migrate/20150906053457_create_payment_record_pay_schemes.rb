class CreatePaymentRecordPaySchemes < ActiveRecord::Migration
  def change
    create_table :payment_record_pay_schemes do |t|
      t.references :pay_type, index: true, foreign_key: true
      t.float :pay
      t.float :pay_ot
      t.float :pay_public_holiday
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps null: false
    end
  end
end
