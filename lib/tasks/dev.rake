desc "Fill the database tables with some sample data"
task sample_data: :environment do
  if Rails.env.development?
    TimesheetEntry.destroy_all
    Message.destroy_all
    Employee.destroy_all
    Company.destroy_all

    company = Company.create!(
      name: Faker::Company.name,
      logo: Faker::Company.logo,
    )

    puts "#{Company.count} companies have been created."

    # Generate sample data for the employees table
    bob = Employee.create!(
      first_name: "Bob",
      last_name: Faker::Name.last_name,
      role: :manager,
      company_id: company.id,
      manager_id: nil, # Assign the manager id to the first employee
      phone_number: Faker::Number.number(digits: 10),
      has_sms: [true, false].sample,
      profile_picture: Faker::LoremFlickr.image(size: "50x50"), # Using Faker::LoremPixel
      time_zone: Faker::Address.time_zone,
      email: "bob@example.com",
      password: "password",
    )

    alice = Employee.create!(
      first_name: "Alice",
      last_name: Faker::Name.last_name,
      role: :employee,
      company_id: company.id, # Assuming there are 5 companies
      manager_id: bob.id, # Assign the manager id to the first employee
      phone_number: Faker::Number.number(digits: 10),
      has_sms: [true, false].sample,
      profile_picture: Faker::LoremFlickr.image(size: "50x50"),
      time_zone: Faker::Address.time_zone,
      email: "alice@example.com",
      password: "password",
    )

    puts "#{Employee.count} employees have been created."

    timesheet_entry_count = 5
    timesheet_entries = []

    timesheet_entry_count.times do
      started_at = Faker::Time.backward(days: 7)
      ended_at = started_at + rand(1..8).hours
      comments = Faker::Lorem.sentence

      # Check for uniqueness
      while timesheet_entries.any? { |entry| entry[:started_at] == started_at }
        started_at = Faker::Time.backward(days: 7)
        ended_at = started_at + rand(1..8).hours
      end

      timesheet_entries << {
        employee_id: alice.id,
        started_at: started_at,
        ended_at: ended_at,
        comments: comments,
        entry_approval_status: "approved",
      }
    end

    # Create timesheet entries
    timesheet_entries.each do |entry|
      TimesheetEntry.create!(entry)
    end

    puts TimesheetEntry.all.inspect

    puts "#{TimesheetEntry.count} timesheet entries have been created."

    puts "Sample data has been successfully generated."
  else
    puts "This task can only be run in the development environment."
  end
end
