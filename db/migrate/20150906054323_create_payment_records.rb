class CreatePaymentRecords < ActiveRecord::Migration
  def change
    create_table :payment_records do |t|
      t.references :employee, index: true, foreign_key: true
      t.float :total_pay
      t.float :bonus
      t.datetime :paid_at

      t.timestamps null: false
    end
  end
end
