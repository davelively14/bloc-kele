require 'httparty'

class Kele
  include HTTParty

  def initialize(email, password)
    @bloc_api_url = "https://www.bloc.io/api/v1/"

    options = {
      body: {
        email: email,
        password: password
      }
    }

    parsed_response = self.class.post("#{@bloc_api_url}sessions/", options)
    
    @auth_token = parsed_response["auth_token"]
  end
end
