class AddConfigToWorkdays < ActiveRecord::Migration
  def change
    add_reference :workdays, :config, index: true, foreign_key: true
  end
end
