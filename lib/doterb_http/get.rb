# frozen_string_literal: true

require "net/http"
require "dry-initializer"
require "json"

module DoterbHttp
  class Get
    extend Dry::Initializer

    option :url
    option :body, optional: true

    def call
      uri = URI.parse(url)
      uri.query = URI.encode_www_form(body) if body
      
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri.request_uri)
      request['Content-Type'] = "application/json"
      request['Accept'] = "application/json"

      response = http.request(request)
      if response.code == '200'
        JSON.parse(response.body)
      else
        raise response.body
      end
    end
  end
end
