require 'addressable'
require 'faraday'
require 'json'
require 'hashie'
require 'time'
require 'rack/request'
require 'rack/response'

require_relative 'kassa/errors'
require_relative 'kassa/configurable'
require_relative 'kassa/client'
require_relative 'kassa/webhooks'
require_relative 'kassa/version'

module Kassa
  class << self
    include Configurable

    def client
      return @client if defined?(@client) && @client.same_options?(options)

      @client = Client.new(options)
    end
  end
end
