require "application_system_test_case"

class DonorsTest < ApplicationSystemTestCase
  setup do
    @donor = donors(:one)
  end

  test "visiting the index" do
    visit donors_url
    assert_selector "h1", text: "Donors"
  end

  test "should create donor" do
    visit donors_url
    click_on "New donor"

    fill_in "City", with: @donor.city
    check "Credit" if @donor.credit
    fill_in "Email", with: @donor.email
    fill_in "First name", with: @donor.first_name
    fill_in "Last name", with: @donor.last_name
    fill_in "Postal", with: @donor.postal
    fill_in "State", with: @donor.state
    fill_in "Street address", with: @donor.street_address
    fill_in "Website", with: @donor.website
    click_on "Create Donor"

    assert_text "Donor was successfully created"
    click_on "Back"
  end

  test "should update Donor" do
    visit donor_url(@donor)
    click_on "Edit this donor", match: :first

    fill_in "City", with: @donor.city
    check "Credit" if @donor.credit
    fill_in "Email", with: @donor.email
    fill_in "First name", with: @donor.first_name
    fill_in "Last name", with: @donor.last_name
    fill_in "Postal", with: @donor.postal
    fill_in "State", with: @donor.state
    fill_in "Street address", with: @donor.street_address
    fill_in "Website", with: @donor.website
    click_on "Update Donor"

    assert_text "Donor was successfully updated"
    click_on "Back"
  end

  test "should destroy Donor" do
    visit donor_url(@donor)
    click_on "Destroy this donor", match: :first

    assert_text "Donor was successfully destroyed"
  end
end
