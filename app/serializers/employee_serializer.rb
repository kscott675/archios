class EmployeeSerializer < ActiveModel::Serializer
  attributes :id, :email, :full_name, :phone_number, :profile_picture, :role, :time_zone, :company_id, :manager_id

  def full_name
    "#{object.first_name} #{object.last_name}"
  end
end
