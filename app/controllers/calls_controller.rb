class CallsController < ApplicationController
  before_action :set_to, only: %i[new add_peer finish]

  def new
    head :no_content
    call = Call.get(call_params[:call_id])
    call = Call.create(call_params[:call_id]) if call.nil?

    ActionCable.server.broadcast("call_channel:#{@to}", call: call, action: params[:new_call] ? 'newCall' : '')
    ActionCable.server.broadcast("call_channel:#{call_params[:current_user_id]}", call: call)
  end

  def add_peer
    head :no_content

    call = Call.get(call_params[:call_id])
    return if call.nil?

    call.add_peer(call_params[:peer_id], call_params[:current_user_id])
    ActionCable.server.broadcast("call_channel:#{@to}", call)
    ActionCable.server.broadcast("call_channel:#{call_params[:current_user_id]}", call)
  end

  def finish
    head :no_content

    Call.finish(call_params[:call_id])
    ActionCable.server.broadcast("call_channel:#{@to}", nil)
  end

  def create
    head :no_content
    ActionCable.server.broadcast('call_channel', call_params)
  end

  private

  def call_params
    params.permit(:call_id, :peer_id, :current_user_id, :new_call)
  end

  def set_to
    @chat = Chat.find(call_params[:call_id])
    @to = @chat.doctor.user_id == call_params[:current_user_id] ? @chat.patient.user_id : @chat.doctor.user_id
  end
end
