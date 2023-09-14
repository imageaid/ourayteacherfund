require "application_system_test_case"

class GrantRequestsTest < ApplicationSystemTestCase
  setup do
    @grant_request = grant_requests(:one)
  end

  test "visiting the index" do
    visit grant_requests_url
    assert_selector "h1", text: "Grant Requests"
  end

  test "should create grant_request" do
    visit grant_requests_url
    click_on "New grant_request"

    fill_in "Amount requested", with: @grant_request.amount_requested
    fill_in "Other purpose", with: @grant_request.other_purpose
    fill_in "Purpose", with: @grant_request.purpose
    fill_in "School year", with: @grant_request.school_year
    fill_in "User", with: @grant_request.user_id
    click_on "Create Grant Request"

    assert_text "Grant Request was successfully created"
    click_on "Back"
  end

  test "should update Grant Request" do
    visit grant_request_url(@grant_request)
    click_on "Edit this grant_request", match: :first

    fill_in "Amount requested", with: @grant_request.amount_requested
    fill_in "Other purpose", with: @grant_request.other_purpose
    fill_in "Purpose", with: @grant_request.purpose
    fill_in "School year", with: @grant_request.school_year
    fill_in "User", with: @grant_request.user_id
    click_on "Update Grant Request"

    assert_text "Grant Request was successfully updated"
    click_on "Back"
  end

  test "should destroy Grant Request" do
    visit grant_request_url(@grant_request)
    click_on "Destroy this grant_request", match: :first

    assert_text "Grant Request was successfully destroyed"
  end
end
