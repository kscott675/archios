class HomeController < ApplicationController
  def index
    homepage_data = {
      message: "Welcome to Our Employee Timesheet ERP Application",
      description: "This application helps manage timesheets, projects, and employee data efficiently.",
      authentication: {
        signed_in: employee_signed_in?, # Check if the employee is signed in using Devise helper
        sign_in_path: new_employee_session_path, # Devise sign-in path
        sign_up_path: new_employee_registration_path # Devise sign-up path
      }
    }
    render json: homepage_data
  end
end
