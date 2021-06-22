module Zoom
  class AccessToken
    attr_reader :code, :redirect_url

    def initialize(code, redirect_url)
      @code = code
      @redirect_url = redirect_url
    end

    def call
      JSON.parse(response)
    end

    private

    def response
      RestClient.post(url, {}, headers)
    end

    def url
      token_base_url + '?' + params_for_url
    end

    def token_base_url
      Rails.application.config.zoom[:token_base_url]
    end

    def params_for_url
      params.map { |key, value| "#{key}=#{value}" }.join('&')
    end

    def params
      {
        grant_type: grant_type,
        code: code,
        redirect_url: redirect_url
      }
    end

    def grant_type
      'authorization_code'
    end

    def headers
      { 'Authorization': "Basic #{authorization_code}" }
    end

    def authorization_code
      Base64.strict_encode64(client_id + ':' + client_secret)
    end

    def client_id
      Rails.application.config.zoom[:client_id]
    end

    def client_secret
      Rails.application.config.zoom[:client_secret]
    end
  end
end
