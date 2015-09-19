class AddNameToPayScheme < ActiveRecord::Migration
  def change
    add_column :pay_schemes, :name, :string
  end
end
