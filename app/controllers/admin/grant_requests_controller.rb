# frozen_string_literal: true

module Admin
  class GrantRequestsController < AdminController
    before_action :load_grant_request, only: %i[show destroy]

    def index
      @grant_requests = GrantRequest.where(school_year: current_school_year)
    end

    def show; end

    def destroy
      @grant_request.destroy
      redirect_to admin_grant_requests_path, notice: 'Grant Request was successfully destroyed.'
    end

    private

      def load_grant_request
        @grant_request = GrantRequest.find(params[:id])
      end
  end
end
