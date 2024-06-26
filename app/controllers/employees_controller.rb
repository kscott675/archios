# frozen_string_literal: true

class EmployeesController < ApplicationController
  before_action :authenticate_employee!
  before_action :set_employee, only: %i[show edit update destroy]

  def show
    @employee = current_employee
  end

  def dashboard
    @employees = current_employee.employees
    render :dashboard, employee: current_employee
  end

  def new
    @employee = Employee.new
  end

  def edit
  end

  def create
    @employee = Employee.new(employee_params)
    respond_to do |format|
      if @employee.save
        format.html { redirect_to employee_url(@employee), notice: "Employee was successfully created." }
        format.json { render :show, status: :created, location: @employee }
      else
        # Render the new action and pass the params back to the view
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to employee_url(@employee), notice: "Employee was successfully updated." }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @employee.destroy

    respond_to do |format|
      format.html { redirect_to employees_url, notice: "Employee was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_employee
    @employee = if current_employee.present?
        current_employee
      else
        Employee.find(params[:id])
      end
  end

  # Only allow a list of trusted parameters through.
  def employee_params
    params.require(:employee).permit(:email, :password, :first_name, :last_name, :role, :company_id, :manager_id,
                                     :phone_number, :has_sms, :profile_picture, :time_zone, :status)
  end
end
