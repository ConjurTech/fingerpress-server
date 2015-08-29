class CreateTimelogs < ActiveRecord::Migration
  def change
    create_table :timelogs do |t|
      t.datetime :date_in
      t.datetime :date_out
      t.references :employee, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
