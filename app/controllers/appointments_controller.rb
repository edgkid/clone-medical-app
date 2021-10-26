class AppointmentsController < ApplicationController
  
  def index

    @appointment = Appointment.new()
    @user = User.where("email = ?", current_user.email)
    @appointments = @appointment.get_appointments_by_doctors ({ini:params[:ini_date], end: params[:end_date], doctor:@user[0].doctor.id })

    render :index
  end

  def index_patient

    @appointment = Appointment.new()
    @user = User.where("email = ?", current_user.email)
    @appointments = @appointment.get_appointments_by_patients ({ini:params[:ini_date], end: params[:end_date], patient:@user[0].patient.id })

    render :index_patient
  end

  def index_all
    
    @appointment = Appointment.new()
    @appointments = @appointment.get_appointments ({ini:params[:ini_date], end: params[:end_date]})

    render :index_all
  end

  def create
    @appointment = Appointment.new(appointment_params)
    authorize @appointment

    if @appointment.save
      redirect_to patient_message_path(@appointment.id)
    end
  end

  def show
    @appointment = Appointment.find( params[:id] )
    #authorize @appointment

    render :show
  end

  def list_patients_appointment_call

    @patient_with_plan = PatientPlan.where("status = ? AND count > ?", "Aprobado", 0).order("count desc")

    render :list_appointmet_call
  end

  def set_appointment_info

    @patient = Patient.find(params[:patient_id])
    @doctor = Doctor.find(params[:doctor_id])
    @patient_plan = PatientPlan.find(params[:patient_plan_id])
    @chat = Chat.new(doctor_id: @doctor.id, patient_id: @patient.id)
    @appointment = Appointment.where("patient_id = ? AND doctor_id = ?", @patient.id, @doctor.id)

    render :new_call_appointment

  end

  def save_appointment_info_by_chat

    date = Date.today.strftime("%d-%m-%y")

    @appointment = Appointment.where("to_char(created_at, 'dd-MM-yy') = ? AND doctor_id = ? AND patient_id = ?", date, params[:doctor_id], params[:patient_id])
      
    if @appointment.length == 0
      @appointment = Appointment.new(patient_id: params[:patient_id], doctor_id: params[:doctor_id])
      @appointment.save!(:validate => false)
    end

    redirect_to '/chats', notice: "La cita fue guarda con exito"

  end

  def save_appointment_info

    date = Date.today.strftime("%d-%m-%y")

    @appointment = Appointment.where("to_char(created_at, 'dd-MM-yy') = ? AND doctor_id = ? AND patient_id = ?", date, params[:doctor_id], params[:patient_id])
      
    if @appointment.length == 0
      @appointment = Appointment.new(patient_id: params[:patient_id], doctor_id: params[:doctor_id])
      @appointment.save!(:validate => false)
    end

    redirect_to '/list-appointment-by-phone', notice: "La cita fue guarda con exito"
    
  end

  private

  # Only allow a list of trusted parameters through.
  def appointment_params
    params.require(:appointment).permit(:patient_id, :doctor_id)
  end

end
