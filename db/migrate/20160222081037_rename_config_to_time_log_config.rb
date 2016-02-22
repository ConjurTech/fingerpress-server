class RenameConfigToTimeLogConfig < ActiveRecord::Migration
  def change
    rename_table :configs, :time_log_configs
  end
end
