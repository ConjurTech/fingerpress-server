class CreateWeekendTypes < ActiveRecord::Migration
  def change
    create_table :weekend_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
