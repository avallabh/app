class Api::V1::AppointmentsController < ApplicationController

  def index
    render json: Appointment.all, status: :ok
  end

  def show
    @appointment = Appointment.find(params[:id])
    render json: @appointment, status: :ok
  end

  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.start_time.future? && @appointment.end_time.future?
      if @appointment.save
        render json: @appointment
      else
        render json: @appointment.errors, status: :unprocessable_entity
      end
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  def update
    @appointment = Appointment.find(params[:id])
    if @appointment.start_time.future? && @appointment.end_time.future?
      if @appointment.update(appointment_params)
        render json: @appointment, status: :ok, location: [:api, @appointment]
      else
        render json: @appointment.errors, status: :unprocessable_entity
      end
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
    head :no_content
  end

  private
  def appointment_params
    params.require(:appointment).permit(:first_name, :last_name, :start_time, :end_time, :comments, :user_id)
  end
end
