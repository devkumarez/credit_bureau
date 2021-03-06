require "application_system_test_case"

class ApplicantsTest < ApplicationSystemTestCase
  setup do
    @applicant = applicants(:one)
  end

  test "visiting the index" do
    visit applicants_url
    assert_selector "h1", text: "Applicants"
  end

  test "creating a Applicant" do
    visit applicants_url
    click_on "New Applicant"

    fill_in "Aadhar number", with: @applicant.aadhar_number
    fill_in "Bank account ifsc", with: @applicant.bank_account_ifsc
    fill_in "Bank account number", with: @applicant.bank_account_number
    fill_in "Email", with: @applicant.email
    fill_in "Monthly recurring inflow", with: @applicant.monthly_recurring_inflow
    fill_in "Monthly recurring outflow", with: @applicant.monthly_recurring_outflow
    fill_in "Pan card", with: @applicant.pan_card
    click_on "Create Applicant"

    assert_text "Applicant was successfully created"
    click_on "Back"
  end

  test "updating a Applicant" do
    visit applicants_url
    click_on "Edit", match: :first

    fill_in "Aadhar number", with: @applicant.aadhar_number
    fill_in "Bank account ifsc", with: @applicant.bank_account_ifsc
    fill_in "Bank account number", with: @applicant.bank_account_number
    fill_in "Email", with: @applicant.email
    fill_in "Monthly recurring inflow", with: @applicant.monthly_recurring_inflow
    fill_in "Monthly recurring outflow", with: @applicant.monthly_recurring_outflow
    fill_in "Pan card", with: @applicant.pan_card
    click_on "Update Applicant"

    assert_text "Applicant was successfully updated"
    click_on "Back"
  end

  test "destroying a Applicant" do
    visit applicants_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Applicant was successfully destroyed"
  end
end
