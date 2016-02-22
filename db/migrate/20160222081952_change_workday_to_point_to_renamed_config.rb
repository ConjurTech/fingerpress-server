class ChangeWorkdayToPointToRenamedConfig < ActiveRecord::Migration
  def change
    remove_index :workdays, name: 'index_workdays_on_config_id'
    remove_foreign_key :workdays, :configs
    rename_column :workdays, :config_id, :time_log_config_id
    add_foreign_key :workdays, :time_log_configs
  end
end
