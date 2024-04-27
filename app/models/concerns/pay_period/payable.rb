module PayPeriod::Payable
  extend ActiveSupport::Concern

  class_methods do
    def current
      today = Date.today
      find_by("started_at <= ? AND ended_at >= ?", today, today)
    end

    def create_current_pay_period
      unless current
        last_ended_at = PayPeriod.last&.ended_at || Date.yesterday
        started_at = last_ended_at + 1.day
        ended_at = started_at + 14.days

        PayPeriod.create!(
          started_at: started_at,
          ended_at: ended_at,
          name: Faker::Movies::HarryPotter.spell,
        )
      end
    end
  end
end
