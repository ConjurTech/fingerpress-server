class AddExtraAttributesToPaySchemes < ActiveRecord::Migration
  def change
    add_column :pay_schemes, :ot_type, :string
    add_column :pay_schemes, :weekend_type, :string
    add_column :pay_schemes, :public_holiday_type, :string
    add_column :pay_schemes, :ot_multiplier, :float
    add_column :pay_schemes, :ot_time_range_start, :time
    add_column :pay_schemes, :ot_time_range_end, :time
    add_column :pay_schemes, :public_holiday_multiplier, :float
    add_column :pay_schemes, :pay_weekend, :float
    add_column :pay_schemes, :weekend_multiplier, :float
  end
end
