# frozen_string_literal: true

module Admin
  class GrantRequestsController < AdminController
    before_action :load_grant_request, only: %i[show destroy]

    def index; end

    def show; end

    def destroy; end

    private

      def load_grant_request
        @grant_request = GrantRequest.find(params[:id])
      end
  end
end
