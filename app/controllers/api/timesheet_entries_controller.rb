module Api
  class TimesheetEntriesController < ApplicationController
    before_action :set_timesheet_entry, only: %i[ show update destroy ]

    # GET /timesheet_entries or /timesheet_entries.json
    def index
      @timesheet_entries = TimesheetEntry.all
    end

    # GET /timesheet_entries/1 or /timesheet_entries/1.json
    def show
    end

    # GET /timesheet_entries/new
    def new
      @timesheet_entry = TimesheetEntry.new
    end

    # GET /timesheet_entries/1/edit
    def edit
    end

    # POST /timesheet_entries or /timesheet_entries.json
    def create
      @timesheet_entry = TimesheetEntry.new

      if @timesheet_entry.save
        render json: @timesheet_entry, status: :created
      else
        render json: @timesheet_entry.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /timesheet_entries/1 or /timesheet_entries/1.json
    def update
      respond_to do |format|
        if @timesheet_entry.update(timesheet_entry_params)
          format.html { redirect_to timesheet_entry_url(@timesheet_entry), notice: "Timesheet entry was successfully updated." }
          format.json { render :show, status: :ok, location: @timesheet_entry }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @timesheet_entry.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /timesheet_entries/1 or /timesheet_entries/1.json
    def destroy
      @timesheet_entry.destroy

      respond_to do |format|
        format.html { redirect_to timesheet_entries_url, notice: "Timesheet entry was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_timesheet_entry
      @timesheet_entry = TimesheetEntry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def timesheet_entry_params
      params.require(:timesheet_entry).permit(:employee_id, :started_at, :ended_at, :hours_worked, :comments)
    end

    def set_default_response_format
      request.format = :json
    end
  end
end
