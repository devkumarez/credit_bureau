json.extract! applicant, :id, :email, :pan_card, :aadhar_number, :bank_account_number, :bank_account_ifsc, :monthly_recurring_inflow, :monthly_recurring_outflow, :created_at, :updated_at
json.url applicant_url(applicant, format: :json)
