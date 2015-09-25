class PayScheme < ActiveRecord::Base
  belongs_to :pay_type
  belongs_to :ot_type
end
