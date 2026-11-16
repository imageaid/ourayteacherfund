# frozen_string_literal: true

class AwardeesController < ApplicationController
  PER_PAGE = 10

  def index
    awardees = GrantDecision.where(approved: true)
                            .with_awardee_feedback
                            .includes(:grant_request, :rich_text_awardee_feedback)
                            .order(created_at: :desc)
    @pagy, @awardees = pagy(awardees, limit: PER_PAGE)
  rescue Pagy::OverflowError
    redirect_to awardees_path
  end
end
