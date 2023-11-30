# frozen_string_literal: true

module Admin
  class MessagesController < AdminController
    before_action :set_message, only: %i[show edit update destroy schedule]

    # GET /messages or /messages.json
    def index
      @messages = Message.all
    end

    # GET /messages/1 or /messages/1.json
    def show; end

    # GET /messages/new
    def new
      @message = Message.new
    end

    # GET /messages/1/edit
    def edit; end

    # POST /messages or /messages.json
    def create
      @message = Message.new(message_params)

      if @message.save
        redirect_to admin_message_path(@message), notice: 'Message was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /messages/1 or /messages/1.json
    def update
      updated = @message.update(message_params)
      if updated
        redirect_to admin_message_path(@message), notice: 'Message was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /messages/1 or /messages/1.json
    def destroy
      @message.destroy
      redirect_to admin_messages_url, notice: 'Message was successfully destroyed.'
    end

    def schedule
      DeliverMessagesJob.set(wait_until: @message.sends_at).perform_later(@message)
      @message.update(status: :scheduled)
      redirect_to admin_messages_path, notice: 'Message was successfully scheduled.'
    end

    private

      # Use callbacks to share common setup or constraints between actions.
      def set_message
        @message = Message.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def message_params
        params.require(:message).permit(:subject, :body, :sends_at, :message_type, :total_delivered, deliver_to: [])
      end
  end
end
