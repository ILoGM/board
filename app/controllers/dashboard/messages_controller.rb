class Dashboard::MessagesController < Dashboard::ApplicationController
  def index
    @messages = current_user.received_messages.unread.active
    @reply = current_user.sent_messages.build
  end

  def create
    @message = current_user.sent_messages.build

    if @message.post(params[:message])
      Message.mark_messages_as_read(params[:message])
      flash[:notice] = t :reply_sent
      redirect_to dashboard_messages_path
    else
      @messages = current_user.received_messages.unread.active
      @reply = @message
      render action: 'index'
    end
  end
end
