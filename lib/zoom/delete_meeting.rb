module Zoom
  class DeleteMeeting
    attr_reader :access_token, :token_type, :meeting_id

    def initialize(access_token, token_type, meeting_id)
      @access_token = access_token
      @token_type = token_type
      @meeting_id = meeting_id
    end

    def call
      delete
    end

    private

    def delete
      RestClient.delete(url, headers)
    end

    def url
      api_base_url + "/meetings/#{meeting_id}"
    end

    def api_base_url
      Rails.application.config.zoom[:api_base_url]
    end

    def headers
      { 'Authorization': "#{token_type} #{access_token}" }
    end
  end
end
