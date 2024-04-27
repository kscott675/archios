class RemoveHasSmsFromEmployees < ActiveRecord::Migration[7.0]
  def change
    remove_column :employees, :has_sms, :boolean
  end
end
