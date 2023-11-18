# frozen_string_literal: true

module Admin
  # manage donors
  class DonorsController < AdminController
    include UserSearchable

    before_action :set_donor, only: %i[show edit update destroy]

    def index
      filters = params[:donor].present? ? params[:donor].slice(:first_name, :last_name, :email) : {}
      @pagy, @donors = pagy(search_scope(filters: filters, model_name: 'Donor'), items: 12)
      @total_donated = Donation.sum(:amount)

      respond_to do |format|
        format.html
        format.turbo_stream
      end
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

      redirect_to admin_donors_url, notice: 'Donor was successfully destroyed.'
    end

    private

      def set_donor
        @donor = Donor.friendly.find(params[:id])
      end

      def donor_params
        params.require(:donor).permit(
          :first_name, :last_name, :email, :street_address, :city, :state, :postal, :website, :credit, :role, :level, :alumni, :how_heard,
          donations_attributes: %i[id amount received_on recurring thanked _destroy]
        )
      end
  end
end
