class SetHoursWorkedDefault < ActiveRecord::Migration[7.0]
  def change
    change_column_default :timesheet_entries, :hours_worked, 0
  end
end
