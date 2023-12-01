# frozen_string_literal: true

module Admin
  class GrantsController < AdminController
    include Admin::Questionable

    before_action :load_grant, only: %i[show edit update destroy]

    def index
      @grants = Grant.all
    end

    def show
    end

    def new
      @grant = Grant.new
    end

    def create
      @grant = Grant.new(grant_params)
      format_grant_questions

      if @grant.save
        redirect_to admin_grant_path(@grant), notice: "Grant was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      @grant.assign_attributes(grant_params)
      format_grant_questions

      if @grant.save
        redirect_to admin_grant_path(@grant), notice: "Grant was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @grant.destroy
      redirect_to admin_grants_path, notice: "Grant was successfully destroyed."
    end

    def question_field
    end

    private

    def load_grant
      @grant = Grant.find(params[:id])
    end

    def grant_params
      params.require(:grant)
        .permit([
          :active, :details, :name,
          {questions: [:question]}
        ])
    end
  end
end
