ActiveSupport.on_load(:good_job_application_controller) do
  before_action do
    raise ActionController::RoutingError, "Not Found" unless current_user&.board_member?
  end
end
