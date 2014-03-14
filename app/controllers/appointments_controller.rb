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
    @user = current_user
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      redirect_to root_path, notice: 'Appointment saved'
    else
      render 'new', notice: 'Error: Appointment not saved'
    end
  end

  def destroy
    Appointment.find(params[:id]).destroy
    redirect_to root_path, notice: 'The appointment was deleted'
  end

  private
  def appointment_params
    params.require(:appointment).permit(:first_name, :last_name, :month, :date, :hour, :minute, :meridiem, :description, :user_id)
  end
end
