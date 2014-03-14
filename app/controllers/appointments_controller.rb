class AppointmentsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :show, :destroy ]

  def index
    @appointments = Appointment.all
  end

  def new
    @appointment = Appointment.new
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      redirect_to root_path, notice: 'Appointment saved'
    else
      redirect_to root_path, notice: 'Error: Appointment not saved'
    end
  end

  def destroy
    Appointment.find(params[:id]).destroy
    redirect_to root_path, notice: 'The appointment was deleted'
  end

  private
  def appointment_params
    params.require(:appointment).permit(:first_name, :last_name, :month, :date, :hour, :minute, :meridiem, :description)
  end
end
