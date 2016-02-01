class CreatePayRoll < ActiveRecord::Migration
  def change
    create_table :pay_rolls do |t|
      t.date :start_date
      t.date :end_date
    end
  end
end
