# frozen_string_literal: true

desc "Fill the database tables with some sample data"
task reset_db: :environment do
  Request.destroy_all
  PayPeriod.destroy_all
  Status.destroy_all
  TimesheetEntry.destroy_all
  Employee.destroy_all
  Company.destroy_all
  TmailSubscription.destroy_all
end
