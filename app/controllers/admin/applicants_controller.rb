# frozen_string_literal: true

module Admin
  class ApplicantsController < AdminController
    before_action :load_applicant, only: %i[show edit update destroy]

    def index
      @applicants = Applicant.current_requests
    end

    def show; end

    def edit; end

    def update; end

    def destroy
      @applicant.destroy
      redirect_to admin_applicants_path, notice: 'Applicant was successfully destroyed.'
    end

    private

      def load_applicant
        @applicant = Applicant.friendly.find(params[:id])
      end

      def applicant_params
        params.require(:applicant).permit(Applicant.permitted_params)
      end
  end
end
