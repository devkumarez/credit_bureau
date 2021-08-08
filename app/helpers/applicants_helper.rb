module ApplicantsHelper

  def formatted_recommendation value
    case value
    when 'deny'
      'REJECT'
    else
      value.upcase
    end
  end

end
