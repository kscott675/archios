# == Schema Information
#
# Table name: pay_periods
#
#  id         :integer          not null, primary key
#  end_date   :date
#  start_date :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PayPeriod < ApplicationRecord
  has_many :timesheet_entries

  def self.current
    today = Date.today
    find_by('start_date <= ? AND end_date >= ?', today, today)
  end
end
