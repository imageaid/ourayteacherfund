# frozen_string_literal: true

module Admin
  class GrantRequestsController < AdminController
    include UserSearchable

    before_action :load_grant_request, only: %i[show destroy]

    def index
      filters = params[:grant_request].present? ? params[:grant_request].slice(:first_name, :last_name, :email) : {}
      @pagy, @grant_requests = pagy(search_scope(filters: filters, model_name: 'GrantRequest').where(school_year: current_school_year), items: 12)

      respond_to do |format|
        format.html
        format.turbo_stream
      end
    end

    def show; end

    def destroy
      @grant_request.destroy
      redirect_to admin_grant_requests_path, notice: 'Grant Request was successfully destroyed.'
    end

    private

      def load_grant_request
        @grant_request = GrantRequest.friendly.find(params[:id])
      end
  end
end
