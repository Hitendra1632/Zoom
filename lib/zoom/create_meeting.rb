module Zoom
  class CreateMeeting
    attr_reader :access_token, :token_type, :params

    def initialize(access_token, token_type, params)
      @access_token = access_token
      @token_type = token_type
      @params = params
    end

    def call
      JSON.parse(response)
    end

    private

    def response
      RestClient.post(url, params.to_json, headers)
    end

    def url
      api_base_url + "/users/me/meetings"
    end

    def api_base_url
      Rails.application.config.zoom[:api_base_url]
    end

    def headers
      { 'Authorization': "#{token_type} #{access_token}",
        'Content-Type': 'application/json' }
    end
  end
end
