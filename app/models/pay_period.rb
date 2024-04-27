# frozen_string_literal: true

# == Schema Information
#
# Table name: pay_periods
#
#  id         :bigint           not null, primary key
#  ended_at   :date
#  name       :string
#  started_at :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PayPeriod < ApplicationRecord
  include PayPeriod::Payable

  has_many :timesheet_entries
end
