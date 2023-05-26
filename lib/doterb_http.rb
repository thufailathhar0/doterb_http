# frozen_string_literal: true

require "doterb_http/version"
require 'doterb_http/get'
require 'doterb_http/post'
require "net/http"
require "dry-initializer"

module DoterbHttp
  class Set
    extend Dry::Initializer

    option :url
    option :method
    option :body, optional: true

    def call
      response =  case method.upcase
                  when 'POST'
                    DoterbHttp::Post.new(url: url, body: body).call
                  when 'GET'
                    DoterbHttp::Get.new(url: url, body: body).call
                  end
      response
    end
  end
end
