require 'test_helper'

class ApplicantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @applicant = applicants(:one)
  end

  test "should get index" do
    get applicants_url
    assert_response :success
  end

  test "should get new" do
    get new_applicant_url
    assert_response :success
  end

  test "should create applicant" do
    assert_difference('Applicant.count') do
      post applicants_url, params: { applicant: { aadhar_number: @applicant.aadhar_number, bank_account_ifsc: @applicant.bank_account_ifsc, bank_account_number: @applicant.bank_account_number, email: @applicant.email, monthly_recurring_inflow: @applicant.monthly_recurring_inflow, monthly_recurring_outflow: @applicant.monthly_recurring_outflow, pan_card: @applicant.pan_card } }
    end

    assert_redirected_to applicant_url(Applicant.last)
  end

  test "should show applicant" do
    get applicant_url(@applicant)
    assert_response :success
  end

  test "should get edit" do
    get edit_applicant_url(@applicant)
    assert_response :success
  end

  test "should update applicant" do
    patch applicant_url(@applicant), params: { applicant: { aadhar_number: @applicant.aadhar_number, bank_account_ifsc: @applicant.bank_account_ifsc, bank_account_number: @applicant.bank_account_number, email: @applicant.email, monthly_recurring_inflow: @applicant.monthly_recurring_inflow, monthly_recurring_outflow: @applicant.monthly_recurring_outflow, pan_card: @applicant.pan_card } }
    assert_redirected_to applicant_url(@applicant)
  end

  test "should destroy applicant" do
    assert_difference('Applicant.count', -1) do
      delete applicant_url(@applicant)
    end

    assert_redirected_to applicants_url
  end
end
