class EmployeeSerializer < ActiveModel::Serializer
  attributes :id, :name, :designation, :fingerprint_registered

  def designation
    object.pay_scheme.try(:name)
  end

  def fingerprint_registered
    object.fingerprint_id.present?
  end
end
