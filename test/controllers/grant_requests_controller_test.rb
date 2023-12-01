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

  test "should create grant_request" do
    assert_difference("GrantRequest.count") do
      post grant_requests_url, params: {grant_request: {amount_requested: @grant_request.amount_requested, other_purpose: @grant_request.other_purpose, purpose: @grant_request.purpose, school_year: @grant_request.school_year, user_id: @grant_request.user_id}}
    end

    assert_redirected_to grant_request_url(GrantRequest.last)
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
