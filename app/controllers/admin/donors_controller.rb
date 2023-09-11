# frozen_string_literal: true

module Admin
  # manage donors
  class DonorsController < AdminController
    before_action :set_donor, only: %i[ show edit update destroy ]

    def index
      @donors = Donor.all
    end

    def show
    end

    def new
      @donor = Donor.new
    end

    def edit
    end

    def create
      @donor = Donor.new(donor_params)

      respond_to do |format|
        if @donor.save
          format.html { redirect_to admin_donor_url(@donor), notice: "Donor was successfully created." }
          format.json { render :show, status: :created, location: @donor }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @donor.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @donor.update(donor_params)
          format.html { redirect_to admin_donor_url(@donor), notice: "Donor was successfully updated." }
          format.json { render :show, status: :ok, location: @donor }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @donor.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @donor.destroy

      respond_to do |format|
        format.html { redirect_to admin_donors_url, notice: "Donor was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private

      def set_donor
        @donor = Donor.friendly.find(params[:id])
      end

      def donor_params
        params.require(:donor).permit(:first_name, :last_name, :email, :street_address, :city, :state, :postal, :website, :credit)
      end
  end
end
