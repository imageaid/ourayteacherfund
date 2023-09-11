# frozen_string_literal: true

module Admin
  class QuestionsController < AdminController
    before_action :load_question, only: %i[show edit update destroy]

    def index; end

    def show; end

    def new; end

    def create; end

    def edit; end

    def update; end

    def destroy; end

    private

      def load_question
        @question = Question.friendly.find(params[:id])
      end
  end
end
