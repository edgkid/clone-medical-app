class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel:#{current_user.id}"
    user = UsersConnected.create(current_user)

    return unless current_user.doctor?

    UsersConnected.patients_gets.each do |u|
      ActionCable.server.broadcast "room_channel:#{u.id}", user: user, action: 'new'
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    UsersConnected.remove(current_user)
    return unless current_user.doctor?

    UsersConnected.patients_gets.each do |u|
      ActionCable.server.broadcast "room_channel:#{u.id}", user: current_user.id, action: 'remove'
    end
  end
end
