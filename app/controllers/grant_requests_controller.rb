class GrantRequestsController < ApplicationController
  include Admin::Questionable

  before_action :load_grant_request, only: %i[show edit update destroy]

  # GET /grant_requests or /grant_requests.json
  def index
    @grant_requests = if params[:grant_id].present?
                        Grant.find(params[:grant_id]).grant_requests
                      else
                        GrantRequest.order(created_at: :desc)
                      end
    @teachers_page = Page.find_by(link_label: 'Teachers')
  end

  # GET /grant_requests/1 or /grant_requests/1.json
  def show; end

  # GET /grant_requests/new
  def new
    @grant = Grant.find_by(active: true)
    @grant_request = GrantRequest.new(grant: @grant)
    @grant_request.build_applicant
  end

  # GET /grant_requests/1/edit
  def edit
    @grant = Grant.find_by(active: true)
  end

  # POST /grant_requests or /grant_requests.json
  def create
    @grant_request = GrantRequest.new(grant_request_params)
    existing_user = User.find_by(email: grant_request_params[:applicant_attributes][:email].downcase.strip)
    if existing_user.present? && !existing_user.applyable?
      redirect_to(new_grant_request_path, alert: 'Email is associatd with another user and cannot be used for an application.') && return
    end

    if existing_user
      existing_user.update(type: 'Applicant')
      @grant_request.applicant = existing_user
    else
      @grant_request.applicant.generate_temp_password
    end

    format_grant_responses

    if @grant_request.save
      GrantRequestsMailer.grant_request_email(@grant_request).deliver_now
      redirect_to grant_request_url(@grant_request), notice: 'Grant request received. An email will be sent shortly with more details. Thank you!'
    else
      @grant = Grant.find_by(active: true)
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /grant_requests/1 or /grant_requests/1.json
  def update
    if @grant_request.update(grant_request_params)
      redirect_to grant_request_url(@grant_request), notice: 'GrantRequest was successfully updated.'
    else
      @grant = Grant.find_by(active: true)
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /grant_requests/1 or /grant_requests/1.json
  def destroy
    @grant_request.destroy

    redirect_to grant_requests_url, notice: 'GrantRequest was successfully destroyed.'
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def load_grant_request
      @grant_request = GrantRequest.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def grant_request_params
      params.require(:grant_request).permit(
        :user_id, :school_year, :amount_requested, :grant_id, :other_data, :purpose,
        questions: {},
        applicant_attributes: %i[email password password_confirmation first_name last_name role active applied_on status phone]
      )
    end
end
