class GrantRequestsController < ApplicationController
  before_action :load_grant_request, only: %i[show edit update destroy]

  # GET /grant_requests or /grant_requests.json
  def index
    @grant_requests = GrantRequest.all
    @teachers_page = Page.find_by(link_label: 'Teachers')
  end

  # GET /grant_requests/1 or /grant_requests/1.json
  def show; end

  # GET /grant_requests/new
  def new
    @grant_request = GrantRequest.new
    @questions = Question.for_grant_requests
  end

  # GET /grant_requests/1/edit
  def edit; end

  # POST /grant_requests or /grant_requests.json
  def create
    @grant_request = GrantRequest.new(grant_request_params)

    respond_to do |format|
      if @grant_request.save
        format.html { redirect_to grant_request_url(@grant_request), notice: 'GrantRequest was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grant_requests/1 or /grant_requests/1.json
  def update
    respond_to do |format|
      if @grant_request.update(grant_request_params)
        format.html { redirect_to grant_request_url(@grant_request), notice: 'GrantRequest was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grant_requests/1 or /grant_requests/1.json
  def destroy
    @grant_request.destroy

    respond_to do |format|
      format.html { redirect_to grant_requests_url, notice: 'GrantRequest was successfully destroyed.' }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def load_grant_request
      @grant_request = GrantRequest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def grant_request_params
      params.require(:grant_request).permit(
        :user_id, :school_year, :amount_requested,
        applicant_attributes: %i[email password password_confirmation first_name last_name role active applied_on requested_for status]
      )
    end
end
