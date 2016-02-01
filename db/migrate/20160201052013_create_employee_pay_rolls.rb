class CreateEmployeePayRolls < ActiveRecord::Migration
  def change
    create_table :employee_pay_rolls do |t|
      t.belongs_to :employee, index: true, foreign_key: true
      t.belongs_to :pay_roll, index: true, foreign_key: true
    end
  end
end
