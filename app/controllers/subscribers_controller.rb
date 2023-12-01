# frozen_string_literal: true

class SubscribersController < ApplicationController
  def create
    existing_user = User.find_by(email: user_params[:email].downcase.strip)
    if existing_user
      @message = "You are already on our email list. Thank you!"
    else
      @user = User.new(user_params)
      @user.generate_temp_password
      @message = if @user.save
        "We have added you to our email list. Thank you!"
      else
        "We were not able to add you: #{@user.errors.full_messages.join(", ")}"
      end
    end

    render turbo_stream: turbo_stream.replace("joinForm", partial: "shared/join_form", locals: {message: @message})
  end

  private

  def user_params
    params.require(:user).permit(:email, :role)
  end
end
