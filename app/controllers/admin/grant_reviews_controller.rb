# frozen_string_literal: true

module Admin
  class GrantReviewsController < AdminController
    def create
      @grant_review = GrantReview.create(grant_review_params)
      Rails.logger.info @grant_review.errors.full_messages.join(', ')

      respond_to do |format|
        format.turbo_stream
      end
    end

    def destroy
      @grant_review = GrantReview.find(params[:id])
      @grant_review.destroy
      respond_to do |format|
        format.turbo_stream
      end
    end

    private

      def grant_review_params
        params.require(:grant_review).permit(:grant_request_id, :user_id, :thoughts)
      end
  end
end
