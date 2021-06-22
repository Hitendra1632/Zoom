module Zoom
  class DataCompliance
    attr_reader :payload

    def initialize(payload)
      @payload = payload
    end

    def call
      notify
    end

    private

    def notify
      RestClient.post(url, params.to_json, headers)
    end

    def url
      data_base_url + '/compliance'
    end

    def data_base_url
      Rails.application.config.zoom[:data_base_url]
    end

    def params
      {
        client_id: client_id,
        user_id: payload['user_id'],
        account_id: payload['account_id'],
        deauthorization_event_received: payload,
        compliance_completed: true
      }
    end

    def headers
      { 'Authorization': "Basic #{authorization_code}",
        'Content-Type': 'application/json' }
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
