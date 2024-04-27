module PayPeriod::Payable
  extend ActiveSupport::Concern

  class_methods do
    def create_current_pay_period
      unless PayPeriod.current
        started_at = PayPeriod.last&.ended_at.to_date + 1.day
        ended_at = started_at + 14.days

        PayPeriod.create!(
          started_at: started_at,
          ended_at: ended_at,
          name: Faker::Movies::HarryPotter.spell
        )
      end
    end
  end
end
