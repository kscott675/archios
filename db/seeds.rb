# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

company = Company.create!(
  name: Faker::TvShows::Simpsons.location,
  logo: Faker::Company.logo,
)

puts "#{Company.count} companies have been created."

yoli = Employee.create!(
  first_name: "Yoli",
  last_name: Faker::Name.last_name,
  role: :manager,
  company_id: company.id,
  manager_id: nil,
  phone_number: Faker::Number.number(digits: 10),
  profile_picture: "yoli.jpg",
  time_zone: Faker::Address.time_zone,
  email: "kqscott19@gmail.com",
  password: "password",
)

bob = Employee.create!(
  first_name: "Bob",
  last_name: Faker::Name.last_name,
  role: :employee,
  company_id: company.id,
  manager_id: yoli.id,
  phone_number: Faker::Number.number(digits: 10),
  profile_picture: "bob.jpg",
  time_zone: Faker::Address.time_zone,
  email: "bob@example.com",
  password: "password",
)

julius = Employee.create!(
  first_name: "Julius",
  last_name: Faker::Name.last_name,
  role: :employee,
  company_id: company.id,
  manager_id: yoli.id,
  phone_number: Faker::Number.number(digits: 10),
  profile_picture: "julius.jpg",
  time_zone: Faker::Address.time_zone,
  email: "julius@example.com",
  password: "password",
)

puts "#{Employee.count} employees have been created."

pay_period = PayPeriod.current

if pay_period.nil?
  started_at = PayPeriod.last.ended_at + 1.day
  ended_at = started_at + 14.days

  PayPeriod.create!(
    started_at: started_at,
    ended_at: ended_at,
    name: Faker::Movies::HarryPotter.spell,
  )
end

# making sample timesheet entries more realistic
WORK_HOURS_RANGE = (4..10)

Employee.all.each do |employee|
  10.times do
    started_at = Faker::Time.between(from: PayPeriod.current.started_at, to: PayPeriod.current.ended_at)

    # Determine the duration of the shift
    shift_duration = rand(WORK_HOURS_RANGE).hours

    # Make sure the shift doesn't exceed the pay period's end
    ended_at = [started_at + shift_duration, PayPeriod.current.ended_at].compact.min

    previous_entry = employee.timesheet_entries.last

    if previous_entry && previous_entry.ended_at.nil?
      # If the previous entry hasn't ended, end it randomly within the typical range
      random_end_time = (previous_entry.started_at + rand(4..8).hours)
      previous_entry.update!(ended_at: random_end_time)
      previous_entry.calculate_hours_worked
    else
      # Create a new entry with calculated start and end times
      TimesheetEntry.create!(
        employee_id: employee.id,
        started_at: started_at,
        ended_at:,
        entry_approval_status: (ended_at.nil? ? "pending" : %w[approved rejected].sample),
        pay_period_id: PayPeriod.current.id,
      )
    end
  end
end
puts "#{TimesheetEntry.count} timesheet entries have been created."

TmailSubscription.create!(
  employee_id: yoli.id,
)

TmailSubscription.create!(
  employee_id: bob.id,
)
