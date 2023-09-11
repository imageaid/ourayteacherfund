# frozen_string_literal: true

module Admin
  class ApplicationsController < AdminController
    before_action :load_application, only: %i[show edit update destroy]

    def index; end

    def show; end

    def new; end

    def create; end

    def edit; end

    def update; end

    def destroy; end

    private

      def load_application
        @application = Application.friendly.find(params[:id])
      end
  end
end
