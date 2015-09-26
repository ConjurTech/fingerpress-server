class ChangePublicHolidayTypeToReference < ActiveRecord::Migration
  def change
    remove_column :pay_schemes, :public_holiday_type
    add_reference :pay_schemes, :public_holiday_type
  end
end
