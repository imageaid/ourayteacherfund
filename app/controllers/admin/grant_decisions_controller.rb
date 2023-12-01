# frozen_string_literal: true

module Admin
  class GrantDecisionsController < AdminController
    before_action :load_grant_request

    def create
      @grant_decision = GrantDecision.new(grant_decision_params)

      if @grant_decision.save
        redirect_to admin_grant_request_path(@grant_request), notice: "The decision was successfully created."
      else
        redirect_to admin_grant_request_path(@grant_request), alert: "Unable to create the decision."
      end
    end

    def update
      @grant_decision = GrantDecision.find(params[:id])

      if @grant_decision.update(grant_decision_params)
        redirect_to admin_grant_request_path(@grant_request), notice: "The decision was successfully updated."
      else
        redirect_to admin_grant_request_path(@grant_request), alert: "Unable to save the decision."
      end
    end

    private

    def load_grant_request
      @grant_request = GrantRequest.friendly.find(params[:grant_request_id])
    end

    def grant_decision_params
      params.require(:grant_decision).permit(:amount_awarded, :approved, :grant_request_id, :user_id)
    end
  end
end
