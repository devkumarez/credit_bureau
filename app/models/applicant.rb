class Applicant < ApplicationRecord
  enum recommendation: [:approve, :deny]

  after_create :verify_creditbility

  def credit_limit
    (self.maximum_possible_emi * self.term_in_months).to_i
  end

  def maximum_possible_emi
    (self.monthly_recurring_inflow.to_f / 2) - ( self.monthly_recurring_outflow.to_f)
  end

  def term_in_months
    # to_i is for edge cases like 5000.01, 10000.50
    case self.maximum_possible_emi.to_i
    when -Float::INFINITY..0
      0
    when 0..5000
      6
    when 5001..10000
      12
    when 10001..20000
      18
    when 20000..Float::INFINITY
      24
    end
  end

  private

  def verify_creditbility
    response = Applicants::Recommendation.execute!(self.email)
    if response.score > 2
      self.approve!
    else
      self.deny!
    end
  end

end
