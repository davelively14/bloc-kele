require 'httparty'
require 'json'

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
    @auth_token.clone
  end

  def get_me
    response = self.class.get("#{@bloc_api_url}users/me/", headers: {"authorization" => @auth_token})
    JSON.parse(response.body)
  end

  def get_mentor_availability
    mentor_id = get_me["current_enrollment"]["mentor_id"]
    response = self.class.get("#{@bloc_api_url}mentors/#{mentor_id}/student_availability/", headers: {"authorization" => @auth_token})
    JSON.parse(response.body)
  end

  def get_roadmap(id)
    response = self.class.get("#{@bloc_api_url}roadmaps/#{id}", headers: {"authorization" => @auth_token})
    JSON.parse(response.body)
  end
end
