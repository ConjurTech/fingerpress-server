class AddGroupIdToPaymentRecords < ActiveRecord::Migration
  def change
    add_column :payment_records, :group_id, :integer
  end
end
