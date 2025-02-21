class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel"
  end

  def receive(data)
  	message = Message.create!(
  		content: data["content"],
  		sender_id: data["sender_id"],
  		recipient_id: data["recipient_id"],
  		conversation_id: data["conversation_id"]
  	)

  	ActionCable.server.broadcast("chat_channel", {
      message: message.content,
      sender: message.sender.name,
      recipient: message.recipient.name
    })
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
