require 'dry/initializer'

require_relative 'api'
require 'faraday_middleware'

module GeoService
  class Client

    extend Dry::Initializer[undefined: false]
    include Api

    option :url, default: proc {
      'http://localhost:3020/v1'
    }
    option :connection, default: proc {
      build_connection
    }

    private

    def build_connection
      Faraday.new(@url) do |conn|
        conn.request :json
        conn.response :json, content_type: /\bjson$/
        conn.adapter Faraday.default_adapter
      end
    end

  end
end
