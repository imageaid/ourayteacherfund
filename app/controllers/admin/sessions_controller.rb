# frozen_string_literal: true

module Admin
  class SessionsController < AdminController
    skip_before_action :login_required

    def new; end

    def create
      @user = login(params[:user][:email], params[:user][:password])

      if @user&.board_member?
        redirect_back_or_to(admin_pages_path, notice: 'Login successful')
      else
        flash.alert = 'Login failed'
        render :new
      end
    end

    def destroy
      logout
      redirect_to(admin_sign_in_path, notice: 'Logged out!')
    end

    private

      def login_params
        params.require(:user).permit(:email, :password)
      end
  end
end
