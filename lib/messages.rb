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

  def create_message(sender, recipient_id, stripped_text, subject=nil, token=nil)
    options = {
      body: {
        "sender" => sender,
        "recipient_id" => recipient_id,
        "subject" => subject,
        "token" => token,
        "stripped-text" => stripped_text
      },
      headers: @headers
    }

    response = self.class.post("#{@bloc_api_url}messages/", options)
    JSON.parse(response.body) ? JSON.parse(response.body) : nil
  end
end
