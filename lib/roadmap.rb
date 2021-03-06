module Roadmap
  def get_roadmap(id)
    response = self.class.get("#{@bloc_api_url}roadmaps/#{id}", headers: @headers)
    JSON.parse(response.body)
  end

  def get_checkpoint(id)
    response = self.class.get("#{@bloc_api_url}checkpoints/#{id}", headers: @headers)
    JSON.parse(response.body)
  end
end
