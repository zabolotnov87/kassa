module Kassa
  ConnectionError = Class.new(StandardError)

  module HttpErrors
    class BaseError < StandardError
      def initialize(env)
        super(format_error_message(env))
      end

      private

      def format_error_message(env)
        "Server returned #{env[:status]}: #{env.body}. Headers: #{env.response_headers.inspect}"
      end
    end

    ResourceNotFoundError = Class.new(BaseError)
    ClientError = Class.new(BaseError)
    ServerError = Class.new(BaseError)
  end
end
