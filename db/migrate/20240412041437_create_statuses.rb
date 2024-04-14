# frozen_string_literal: true

class CreateStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :statuses do |t|
      t.string :text
      t.references :employee, foreign_key: true
      t.timestamps
    end
  end
end
