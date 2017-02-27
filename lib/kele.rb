require 'httparty'
require 'json'
require '/Users/DavesMac/Projects/bloc/bloc-kele/lib/roadmap.rb'
require '/Users/DavesMac/Projects/bloc/bloc-kele/lib/messages.rb'

class Kele
  include HTTParty
  include Roadmap
  include Messages

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

    @headers = {
      # "content_type" => 'application/json',
      "authorization" => @auth_token
    }
  end

  def get_token
    @auth_token.clone
  end

  def get_me
    response = self.class.get("#{@bloc_api_url}users/me/", headers: @headers)
    JSON.parse(response.body)
  end

  def get_mentor_availability
    mentor_id = get_me["current_enrollment"]["mentor_id"]
    response = self.class.get("#{@bloc_api_url}mentors/#{mentor_id}/student_availability/", headers: @headers)
    JSON.parse(response.body)
  end
end
