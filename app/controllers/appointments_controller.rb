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
    unless @appointment.user_id == current_user.id
      flash[:alert] = "Access Denied"
      redirect_to root_path
    end
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def create
    @user = current_user
    @appointment = Appointment.new(appointment_params)
    @appointment.end_time = @appointment.start_time + 15.minutes
    if @appointment.save
      flash[:success] = 'Appointment saved'
      redirect_to root_path
    else
      flash[:alert] = 'Error: Appointment not saved'
      render 'new'
    end
  end

  def update
    @appointment = Appointment.find(params[:id])
    @appointment.end_time = @appointment.start_time + 15.minutes
    if @appointment.update(appointment_params)
      flash[:success] = 'Appointment updated'
      redirect_to root_path
    else
      flash[:alert] = 'Appointment failed to update'
      render 'edit'
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    if current_user != nil && @appointment.user_id == current_user.id
      @appointment.destroy
      flash[:notice] = "Appointment was successfully deleted."
      redirect_to root_path
    else
      flash[:alert] = "Access Denied"
      redirect_to root_path
    end
  end

  private
  def appointment_params
    params.require(:appointment).permit(:first_name, :last_name, :start_time, :end_time, :description, :user_id)
  end
end
