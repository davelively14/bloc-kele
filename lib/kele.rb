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

    @auth_token = self.class.post("#{@bloc_api_url}sessions/", options)["auth_token"]

    if !@auth_token
      raise "Email and/or password provided is not valid"
    end
  end

  def get_token
    @auth_token
  end
end
