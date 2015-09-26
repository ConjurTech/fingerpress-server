class CreatePublicHolidayTypes < ActiveRecord::Migration
  def change
    create_table :public_holiday_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
