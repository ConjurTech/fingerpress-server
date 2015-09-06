class ChangeColumnNameForTimeLog < ActiveRecord::Migration
  def change
    change_table :time_logs do |t|
      t.rename :date_in, :date_time_in
      t.rename :date_out, :date_time_out
    end
  end
end
