class MessagesController < ApplicationController
  before_action :set_chat, only: %i[patient doctor create]
  before_action :build_message, only: %i[patient doctor]

  def index
    @chat = Chat.new
    @doctors = UsersConnected.doctors_gets

    @user = User.where("email = ?", current_user.email)
    @patient = Patient.where("user_id = ? ", @user[0].id)
    if @patient.length != 0
      #@patient_plan = PatientPlan.where("patient_id = ? ", @patient[0].id).order('id DESC')
      @patient_plan = PatientPlan.new
      @patient_plan =  @patient_plan.get_actual_patient_plans(@patient[0].id)
    end
    authorize Message, :index?
  end

  def patient
    @user = 'patient'

    authorize @message
    render :new_patient, layout: 'application_patient'

    #@user = User.where("email = ?", current_user.email)
    #@patient = Patient.where("user_id = ? ", @user[0].id)
    #@patient_plan = PatientPlan.where("patient_id = ? ", @patient[0].id).order('id DESC')

    #if @patient_plan[0].update_attribute :count, @patient_plan[0].count - 1
     # authorize @message
      #render :new_patient, layout: 'application_patient'
    #else
      #redirect_to '/chats', alert: "Usted necesita un plan"
    #end
  end

  def doctor
    @user = 'doctor'
    authorize @message
    render :new
  end

  def create
    @message = Message.new message_params
    @message.chat_id = @chat.id
    # user = @message.user. == 'doctor' ? 'doctor' : 'patient'

    user_type = current_user.doctor? ? 'patient' : 'doctor'
    to = @chat.send(:"#{user_type}").try(:user).try(:id)

    if @message.save
      ActionCable.server.broadcast(
        "room_channel:#{to}", 
        message: @message.to_json(methods: :image_url),
        action: 'new_message'
      )

      ActionCable.server.broadcast(
        "room_channel:#{message_params[:user_id]}",
        message: @message.to_json(methods: :image_url),
        action: 'new_message'
      )
    end
  end

  private

  def set_chat

    @chat = Chat.find(params[:chat_id])
    authorize @chat, :show?
  end

  def build_message
    @messages = @chat.messages.all
    @message = Message.new chat: @chat
  end

  def message_params
    params.require(:message).permit(:content, :image, :user_id)
  end
end
