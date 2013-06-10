class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def show
    @message = find_message
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @message.save!

    redirect_to @message
  end

  def edit
    @message = find_message
  end

  def update
    @message = find_message
    @message.assign_attributes(message_params)
    @message.save

    redirect_to @message
  end

  def destroy
    message_id = params.fetch(:id)
    Message.destroy(message_id)

    redirect_to action: :index
  end

  protected

  def find_message(message_id = nil)
    message_id ||= params.fetch(:id)
    Message.find(message_id)
  end

  def message_params
    params.require(:message).permit(:name, :coordinates, :cipher_text)
  end
end
