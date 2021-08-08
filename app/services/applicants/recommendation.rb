module Applicants

  class Recommendation
    require 'net/http'
    require 'uri'

    # this should be moved to env vars
    APIKEY = "uA6TuVzTHWADhBuZYaRND38YTsLgFihx"

    def initialize email
      @email = email
    end

    def self.execute!(email)
      new(email).execute!
    end

    def execute!
      response = verify_user!
      build_response(creditbility_score(response))
    end

    private

    def verify_user!
      uri = URI.parse("https://api.fullcontact.com/v2/person.json")
      uri.query = URI.encode_www_form({ email: @email })

      request = Net::HTTP::Get.new(uri)
      request["X-Fullcontact-Apikey"] = APIKEY

      req_options = {
        use_ssl: uri.scheme == "https",
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end

      if response.code.to_i == 200
        parse_response(response.body)
      else
        Rails.logger.info "AR: failed to fetch #{response.message}"
      end

      # due to some issues on fullcontact API, using the mock response as recommended by Sumisha
      parse_response(mock_response)
    end

    def creditbility_score response
      score = 0
      score += response.socialProfiles.count if response.socialProfiles
      score += 1 if any_approved_loans?

      score
    end

    # this method can be moved to applicant, when we have an actual user
    # for now marking same emails to be an user.
    def any_approved_loans?
      Applicant.where(email: @email, recommendation: Applicant::recommendations[:approve]).exists?
    end

    def parse_response response
      JSON.parse(response, object_class: OpenStruct)
    end

    def build_response score
      OpenStruct.new(status?: true, score: score)
    end

    def mock_response
      res = {
        "status": 200,
        "requestId": "e158b690-4c96-4542-bd1a-f5a374580156",
        "likelihood": 0.95,
        "contactInfo": {
          "familyName": "Raphy",
          "fullName": "Renil Raphy",
          "givenName": "Renil"
        },
        "organizations": [
          {
            "isPrimary": false,
            "name": "Skreem",
            "startDate": "2016-03",
            "title": "Software Developer",
            "current": true
          },
          {
            "isPrimary": false,
            "name": "Carettech Cosultancy Ltd",
            "startDate": "2013-10",
            "title": "Junior Software Engineer",
            "current": true
          }
        ],
        "demographics": {
          "locationDeduced": {
            "deducedLocation": "Thrissur, Kerala, India",
            "city": {
              "deduced": false,
              "name": "Thrissur"
            },
            "state": {
              "deduced": false,
              "name": "Kerala"
            },
            "country": {
              "deduced": false,
              "name": "India",
              "code": "IN"
            },
            "continent": {
              "deduced": true,
              "name": "Asia"
            },
            "county": {
              "deduced": true,
              "name": "Thrissur District"
            },
            "likelihood": 1
          },
          "gender": "Male",
          "locationGeneral": "Thrissur, Kerala, India"
        },
        "socialProfiles": [
          {
            "bio": "I am working on Web applications mainly in 'Ruby on Rails', and have knowledge in 'Django' framework too.",
            "followers": 272,
            "following": 272,
            "type": "linkedin",
            "typeId": "linkedin",
            "typeName": "LinkedIn",
            "url": "https://www.linkedin.com/in/renil-raphy-16a35661",
            "username": "renil-raphy-16a35661",
            "id": "218837602"
          },
          {
            "followers": 28,
            "following": 34,
            "type": "twitter",
            "typeId": "twitter",
            "typeName": "Twitter",
            "url": "https://twitter.com/renilraphyp100",
            "username": "renilraphyp100",
            "id": "1269251400"
          }
        ]
      }
      

      # as we have hardcoded our response social profile count won't exceed 2.
      # this will add social profile randomly to users.

      res[:socialProfiles] << {
        "bio": "Full-Stack Developer",
        "followers": 500,
        "following": 1,
        "type": "facebook",
        "typeId": "facebook",
        "typeName": "Facebook",
        "url": "https://www.facebook.com/devmahato",
        "username": "dev_kumar_fb",
        "id": "837292"
      } if rand(1..3) == 3

      # as api will give us JSON instead of hash.
      res.to_json
    end


  end
end


