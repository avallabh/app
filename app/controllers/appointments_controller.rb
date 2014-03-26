class AppointmentsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :destroy, :edit]

  def index
    if params[:start_time] || params[:end_time]
      @appointments = Appointment.all
      @start_time = Chronic.parse(params[:start_time]).to_datetime
      @end_time = Chronic.parse(params[:end_time]).to_datetime
      @appointments = Appointment.find_appointments_in_range(@start_time, @end_time)
    else
      @appointments = Appointment.all
    end
  end

  def new
    @appointment = Appointment.new
  end

  def edit
    @appointment = Appointment.find(params[:id])
    # unless @appointment.user_id == current_user.id
    #   flash[:alert] = "Access Denied"
    #   redirect_to root_path
    # end
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.start_time.future? && @appointment.end_time.future?
      if @appointment.save
        flash[:success] = 'Appointment saved'
        redirect_to root_path
      else
        flash[:alert] = 'Error: Appointment not saved'
        render 'new'
      end
    else
      flash[:alert] = 'Error: Appointment must be in the future'
      render 'new'
    end
  end

  def update
    @appointment = Appointment.find(params[:id])

    if @appointment.start_time.future? && @appointment.end_time.future?
      if @appointment.update(appointment_params)
        flash[:success] = 'Appointment updated'
        redirect_to root_path
      else
        flash[:alert] = 'Appointment failed to update'
        render 'edit'
      end
    else
      flash[:alert] = 'Error: Appointment must be in the future'
      render 'edit'
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    # if current_user != nil && @appointment.user_id == current_user.id
    if @appointment.destroy
      flash[:notice] = "Appointment was successfully deleted"
      redirect_to root_path
    # else
    #   flash[:alert] = "Access Denied"
    #   redirect_to root_path
    end
  end

  private
  def appointment_params
    params.require(:appointment).permit(:first_name, :last_name, :start_time, :end_time, :comments, :user_id)
  end

  # def find_appointments_in_range(start_time, end_time)
  #   Appointment.where("start_time >= ? AND end_time <= ?", @start_time, @end_time).order(:start_time)
  # end
end
