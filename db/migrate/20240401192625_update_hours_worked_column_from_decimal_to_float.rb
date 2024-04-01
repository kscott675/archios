class UpdateHoursWorkedColumnFromDecimalToFloat < ActiveRecord::Migration[7.0]
  def change
    change_column :timesheet_entries, :hours_worked, :float
  end
end
