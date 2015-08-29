class CreatePaySchemes < ActiveRecord::Migration
  def change
    create_table :pay_schemes do |t|
      t.references :pay_type, index: true, foreign_key: true
      t.float :pay
      t.float :pay_ot
      t.float :pay_public_holiday

      t.timestamps null: false
    end
  end
end
