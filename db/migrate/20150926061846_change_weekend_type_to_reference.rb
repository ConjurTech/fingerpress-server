class ChangeWeekendTypeToReference < ActiveRecord::Migration
  def change
    remove_column :pay_schemes, :weekend_type
    add_reference :pay_schemes, :weekend_type
  end
end
