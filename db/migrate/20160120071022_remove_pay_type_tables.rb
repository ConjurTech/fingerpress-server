class RemovePayTypeTables < ActiveRecord::Migration
  def change
    remove_foreign_key :payment_record_pay_schemes, :pay_types
    remove_foreign_key :pay_schemes, :pay_types
    remove_foreign_key :payment_record_pay_schemes, :ot_types
    remove_foreign_key :payment_record_pay_schemes, :weekend_types
    remove_foreign_key :payment_record_pay_schemes, :public_holiday_types

    remove_column :payment_record_pay_schemes, :pay_type_id
    remove_column :payment_record_pay_schemes, :ot_type_id
    remove_column :payment_record_pay_schemes, :weekend_type_id
    remove_column :payment_record_pay_schemes, :public_holiday_type_id

    remove_column :pay_schemes, :pay_type_id
    remove_column :pay_schemes, :ot_type_id
    remove_column :pay_schemes, :weekend_type_id
    remove_column :pay_schemes, :public_holiday_type_id

    drop_table :ot_types
    drop_table :weekend_types
    drop_table :pay_types
    drop_table :public_holiday_types

    add_column :payment_record_pay_schemes, :pay_type, :string, default: "hourly"
    add_column :payment_record_pay_schemes, :ot_type, :string, default: "hourly"
    add_column :payment_record_pay_schemes, :weekend_type, :string, default: "same_as_normal"
    add_column :payment_record_pay_schemes, :public_holiday_type, :string, default: "same_as_normal"

    add_column :pay_schemes, :pay_type, :string, default: "hourly"
    add_column :pay_schemes, :ot_type, :string, default: "hourly"
    add_column :pay_schemes, :weekend_type, :string, default: "same_as_normal"
    add_column :pay_schemes, :public_holiday_type, :string, default: "same_as_normal"
  end
end
