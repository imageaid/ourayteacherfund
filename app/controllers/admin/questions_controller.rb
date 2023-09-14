# frozen_string_literal: true

module Admin
  class QuestionsController < AdminController
    before_action :load_question, only: %i[show edit update destroy]
    before_action :load_grant_requests, only: %i[new create edit update]

    def index
      @questions = Question.where(active: true).order(:position)
    end

    def show; end

    def new
      @question = Question.new
    end

    def create
      @question = Question.new(question_params)

      if @question.save
        redirect_to admin_questions_path, notice: 'Question was successfully created.'
      else
        render :new
      end
    end

    def edit; end

    def update
      if @question.update(question_params)
        redirect_to admin_questions_path, notice: 'Question was successfully updated.'
      else
        render :edit
      end
    end

    def destroy; end

    private

      def load_grant_requests
        @grant_requests = GrantRequest.all
      end

      def load_question
        @question = Question.find(params[:id])
      end

      def question_params
        params.require(:question).permit(%i[question active position])
      end
  end
end
