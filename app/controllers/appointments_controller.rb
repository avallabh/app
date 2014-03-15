class AppointmentsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :destroy, :edit]

  def index
    @appointments = Appointment.all
  end

  def new
    @appointment = Appointment.new
  end

  def edit
    @appointment = Appointment.find(params[:id])
    @appointment.end_time = @appointment.start_time + 15.minutes
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def create
    @user = current_user
    @appointment = Appointment.new(appointment_params)
    @appointment.end_time = @appointment.start_time + 15.minutes
    if @appointment.save
      redirect_to root_path, notice: 'Appointment saved'
    else
      render 'new', notice: 'Error: Appointment not saved'
    end
  end

  def update
    @appointment = Appointment.find(params[:id])
    @appointment.end_time = @appointment.start_time + 15.minutes
    if @appointment.update(appointment_params)
      redirect_to root_path, notice: 'Appointment was updated'
    else
      redirect_to root_path, notice: 'Appointment failed to update'
    end
  end

  def destroy
    Appointment.find(params[:id]).destroy
    redirect_to root_path, notice: 'The appointment was deleted'
  end

  private
  def appointment_params
    params.require(:appointment).permit(:first_name, :last_name, :start_time, :end_time, :description, :user_id)
  end
end
