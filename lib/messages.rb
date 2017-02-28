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

  def create_message(attrs)
    confirm_attrs(["sender", "recipient_id", "stripped_text"], attrs)
    response = self.class.post("#{@bloc_api_url}messages/", {body: attrs, headers: @headers})
    JSON.parse(response.body) ? JSON.parse(response.body) : nil
  end
end
