class AddFingerprintIdToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :fingerprint_id, :integer
  end
end
