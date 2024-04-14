# frozen_string_literal: true

class AddCurrentStatusToEmployeesTable < ActiveRecord::Migration[7.0]
  def change
    add_column :employees, :current_status, :string
  end
end