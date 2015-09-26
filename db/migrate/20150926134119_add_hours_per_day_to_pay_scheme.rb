class AddHoursPerDayToPayScheme < ActiveRecord::Migration
  def change
    add_column :pay_schemes, :hours_per_day, :float
  end
end
