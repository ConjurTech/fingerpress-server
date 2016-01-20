class ChangeDefaultPayTypesToNil < ActiveRecord::Migration
  def change
    change_column_default :payment_record_pay_schemes, :pay_type, nil
    change_column_default :payment_record_pay_schemes, :ot_type, nil
    change_column_default :payment_record_pay_schemes, :weekend_type, nil
    change_column_default :payment_record_pay_schemes, :public_holiday_type, nil

    change_column_default :pay_schemes, :pay_type, nil
    change_column_default :pay_schemes, :ot_type, nil
    change_column_default :pay_schemes, :weekend_type, nil
    change_column_default :pay_schemes, :public_holiday_type, nil
  end
end
