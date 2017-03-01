require 'httparty'
require 'json'
# TODO reduce to the project path. Using full path because my IRB apparently resides in the bin.
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

  def create_submission(*attrs)
    body = attrs.first
    confirm_attrs(["checkpoint_id", "enrollment_id"], body)
    self.class.post("#{@bloc_api_url}checkpoint_submissions/", {body: body, headers: @headers})
  end

  private

  # Receives Array of required keys and a Hash of attributes
  def confirm_attrs(required, attrs)
    raise "The pramater you passed needs be a Hash of attributes. You passed a #{attrs.class}." unless attrs.is_a? Hash
    required.each do |req|
      raise "#{req} key required, of type #{req.class}" unless attrs[req]
    end
  end
end
