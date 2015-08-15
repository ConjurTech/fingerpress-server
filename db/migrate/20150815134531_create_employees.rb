class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :sex
      t.datetime :birthdate
      t.datetime :joindate
      t.datetime :leavedate
      t.string :bankdetails

      t.timestamps
    end
  end
end
