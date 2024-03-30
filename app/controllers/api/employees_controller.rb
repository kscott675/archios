class EmployeesController < ApplicationController
  before_action :authenticate_employee!, only: [:update, :edit, :show, :dashboard]
  before_action :set_employee, only: %i[ dashboard edit update destroy show ]

  # GET /employees or /employees.json
  def dashboard
  end
  # GET /employees/1 or /employees/1.json
  def show
    # Assuming current_employee could be nil, which is unusual with Devise's authenticate_employee!
    if current_employee.nil?
      render json: { error: "Employee not found. Please log in.", redirect_url: root_url }, status: :unauthorized
    else
      @employee = current_employee
      render json: @employee
    end
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees or /employees.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to employee_url(@employee), notice: "Employee was successfully created." }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1 or /employees/1.json
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

  # DELETE /employees/1 or /employees/1.json
  def destroy
    @employee.destroy

    respond_to do |format|
      format.html { redirect_to employees_url, notice: "Employee was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:employee).permit(:employee_id, :email, :password, :first_name, :last_name, :role, :company_id, :manager_id, :phone_number, :has_sms, :profile_picture, :time_zone)
    end
end
