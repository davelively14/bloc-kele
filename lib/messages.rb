module Messages
  def get_messages(page = nil)
    if page
      response = self.class.get("#{@bloc_api_url}message_threads/", {page: page, headers: @headers})
      JSON.parse(response.body)
    else
      response = self.class.get("#{@bloc_api_url}message_threads/", headers: @headers)
      JSON.parse(response.body)
    end
  end

  def create_message(*attrs)
    body = attrs.first
    confirm_attrs(["sender", "recipient_id", "stripped_text"], body)
    self.class.post("#{@bloc_api_url}messages/", {body: body, headers: @headers})
  end
end
