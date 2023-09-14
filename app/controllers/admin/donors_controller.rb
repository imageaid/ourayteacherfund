# frozen_string_literal: true

module Admin
  # manage donors
  class DonorsController < AdminController
    before_action :set_donor, only: %i[show edit update destroy]

    def index
      @donors = Donor.order(created_at: :desc)
    end

    def show; end

    def new
      @donor = Donor.new
      @donor.donations.build
    end

    def edit; end

    def create
      existing_user = User.find_by(email: donor_params[:email].downcase.strip)
      if existing_user
        message = 'You are already on our email list. Thank you!'
      else
        @donor = Donor.new(donor_params)
        @donor.generate_temp_password
        message = if @donor.save
                    'Donor added. Thank you!'
                  else
                    "We were not able to add you: #{@donor.errors.full_messages.join(', ')}"
                  end
      end

      if @donor.persisted?
        redirect_to admin_donor_url(@donor), notice: message
      else
        render :new, status: :unprocessable_entity, alert: message
      end
    end

    def update
      if @donor.update(donor_params)
        redirect_to admin_donor_url(@donor), notice: 'Donor was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @donor.destroy

      respond_to do |format|
        format.html { redirect_to admin_donors_url, notice: 'Donor was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

      def set_donor
        @donor = Donor.friendly.find(params[:id])
      end

      def donor_params
        params.require(:donor).permit(
          :first_name, :last_name, :email, :street_address, :city, :state, :postal, :website, :credit,
          donations_attributes: %i[id amount received_on recurring thanked _destroy]
        )
      end
  end
end
