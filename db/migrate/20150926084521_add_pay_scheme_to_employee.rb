class AddPaySchemeToEmployee < ActiveRecord::Migration
  def change
    add_reference :employees, :pay_scheme, index: true, foreign_key: true
  end
end
