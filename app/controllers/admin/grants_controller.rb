# frozen_string_literal: true

module Admin
  class GrantsController < AdminController
    before_action :load_grant, only: %i[show edit update destroy]

    def index
      @grants = Grant.all
    end

    def show; end

    def new
      @grant = Grant.new
    end

    def create
      @grant = Grant.new(grant_params)

      if @grant.save
        redirect_to admin_grant_path(@grant), notice: 'Grant was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @grant.update(grant_params)
        redirect_to admin_grant_path(@grant), notice: 'Grant was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @grant.destroy
      redirect_to admin_grants_path, notice: 'Grant was successfully destroyed.'
    end

    private

      def load_grant
        @grant = Grant.find(params[:id])
      end

      def grant_params
        params.require(:grant).permit(%i[active dtails name])
      end
  end
end
