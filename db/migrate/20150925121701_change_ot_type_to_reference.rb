class ChangeOtTypeToReference < ActiveRecord::Migration
  def change
    remove_column :pay_schemes, :ot_type
    add_reference :pay_schemes, :ot_type
  end
end
