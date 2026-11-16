# frozen_string_literal: true

module Admin
  class GrantRequestsController < AdminController
    include UserSearchable

    before_action :load_grant_request, only: %i[show destroy]

    ALL_YEARS = "all"

    def index
      filters = params[:grant_request].present? ? params[:grant_request].slice(:first_name, :last_name, :email) : {}
      @school_year = selected_school_year(filters)
      @school_years = school_year_options

      grant_requests = search_scope(filters: filters, model_name: "GrantRequest")
      grant_requests = grant_requests.where(school_year: @school_year) unless @school_year == ALL_YEARS
      @pagy, @grant_requests = pagy(grant_requests, limit: 12)

      respond_to do |format|
        format.html
        format.turbo_stream
      end
    end

    def show
    end

    def destroy
      @grant_request.destroy
      redirect_to admin_grant_requests_path, notice: "Grant Request was successfully destroyed."
    end

    private

    # Defaults to the current school year. A name/email search with no year
    # chosen looks across all years, so past applicants can be found.
    def selected_school_year(filters)
      return params[:school_year] if params[:school_year].present?

      filters.values.any?(&:present?) ? ALL_YEARS : current_school_year
    end

    # Every school year that has requests, newest first, plus the current one.
    def school_year_options
      years = GrantRequest.where.not(school_year: [ nil, "" ]).distinct.pluck(:school_year)
      (years | [ current_school_year ]).sort.reverse
    end

    def load_grant_request
      @grant_request = GrantRequest.friendly.find(params[:id])
    end
  end
end
