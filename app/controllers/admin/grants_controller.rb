# frozen_string_literal: true

module Admin
  class GrantsController < AdminController

    def index; end

    def show; end

    def new; end

    def create; end

    def edit; end

    def update; end

    def destroy; end

    private

      def load_grant
        @grant = Grant.find(params[:id])
      end

      def grant_params
        params.require(:grant).permit(%i[active dtails name])
      end
  end
end
