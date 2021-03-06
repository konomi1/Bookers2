class MessagesController < ApplicationController

  def create
    @message = current_user.messages.new(message_params)
    @message.save
    redirect_back(fallback_location: root_path)
  end

  private
  def message_params
    params.require(:message).permit(:room_id, :message)
  end

end
