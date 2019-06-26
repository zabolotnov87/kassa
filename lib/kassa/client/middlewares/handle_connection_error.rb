module Kassa
  class Client
    module Middlewares
      class HandleConnectionError < Faraday::Middleware
        FARADAY_CONNECTION_ERRORS = [
          Faraday::TimeoutError,
          Faraday::ConnectionFailed,
          Faraday::SSLError,
        ].freeze

        def call(env)
          @app.call(env)
        rescue *FARADAY_CONNECTION_ERRORS => _e
          raise ConnectionError
        end

        Faraday::Middleware.register_middleware(kassa_handle_connection_error: self)
      end
    end
  end
end
