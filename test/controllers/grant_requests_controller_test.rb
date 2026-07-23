require "test_helper"

class GrantRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @grant_request = grant_requests(:one)
  end

  test "should get index" do
    get grant_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_grant_request_url
    assert_response :success
  end

  def application_params(quiz: "white", website_url: "", email: "new.applicant@example.com")
    {
      website_url: website_url,
      grant_request: {
        grant_id: grants(:one).id,
        school_year: "2024-2025",
        amount_requested: 500,
        purpose: "tuition",
        questions: {"0" => {question: "Why do you need this grant?", response: "For my classroom."}},
        applicant_attributes: {first_name: "Jane", last_name: "Doe", email:, quiz:, role: "applicant", status: "pending", applied_on: Time.zone.now}
      }
    }
  end

  test "should create grant_request when the verification question is answered correctly" do
    assert_difference("GrantRequest.count") do
      post grant_requests_url, params: application_params(quiz: "white")
    end

    assert_redirected_to grant_request_url(GrantRequest.last)
  end

  test "verification answer is case-insensitive and tolerates surrounding whitespace" do
    assert_difference("GrantRequest.count") do
      post grant_requests_url, params: application_params(quiz: "  WHITE ")
    end
  end

  test "should not create grant_request when the verification question is wrong" do
    assert_no_difference("GrantRequest.count") do
      post grant_requests_url, params: application_params(quiz: "black")
    end

    assert_response :unprocessable_entity
  end

  test "should not create grant_request when the verification question is blank" do
    assert_no_difference("GrantRequest.count") do
      post grant_requests_url, params: application_params(quiz: "")
    end

    assert_response :unprocessable_entity
  end

  test "should not create grant_request when the honeypot field is filled" do
    assert_no_difference("GrantRequest.count") do
      post grant_requests_url, params: application_params(quiz: "white", website_url: "http://spam.example")
    end

    assert_response :unprocessable_entity
  end

  test "should show grant_request" do
    get grant_request_url(@grant_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_grant_request_url(@grant_request)
    assert_response :success
  end

  test "should update grant_request" do
    patch grant_request_url(@grant_request), params: {grant_request: {amount_requested: @grant_request.amount_requested, other_purpose: @grant_request.other_purpose, purpose: @grant_request.purpose, school_year: @grant_request.school_year, user_id: @grant_request.user_id}}
    assert_redirected_to grant_request_url(@grant_request)
  end

  test "should destroy grant_request" do
    assert_difference("GrantRequest.count", -1) do
      delete grant_request_url(@grant_request)
    end

    assert_redirected_to grant_requests_url
  end
end
