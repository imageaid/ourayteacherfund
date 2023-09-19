# frozen_string_literal: true

module Admin
  module Questionable
    extend ActiveSupport::Concern

    def format_grant_questions
      questions_array = []
      grant_params[:questions].to_h.each do |_key, value|
        questions_array << value[:question]
      end
      @grant.assign_attributes(questions: questions_array)
    end

    def format_grant_responses
      responses_hash = {}.with_indifferent_access
      grant_request_params[:questions].to_h.each do |_key, value|
        responses_hash[:"#{value[:question]}"] = value[:response]
      end
      @grant_request.assign_attributes(responses: responses_hash)
    end
  end
end
