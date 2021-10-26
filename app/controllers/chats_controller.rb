class ChatsController < ApplicationController
  def index
    @chats = Chat.all
    authorize @chats
    render :index
  end

  def create

    if params[:plan_id] != "0"
      
      @chat = Chat.find_or_initialize_by(chat_params)
      authorize @chat

      if @chat.save
       redirect_to patient_message_path(@chat.id)
      end

    else
      redirect_to '/chats', alert: "por favor indique un plan para el pago de consulta."
    end


  end

  def show
    @chat = Chat.find(params[:id])
    authorize @chat

    render :show
  end

  private

  def chat_params
    #params.require(:chat).permit(:patient_id, :doctor_id)
    params.permit(:patient_id, :doctor_id)
  end
end
