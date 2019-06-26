module Kassa
  class Client
    module Middlewares
      class HandleHttpError < Faraday::Response::Middleware
        def on_complete(env)
          case env.status
          when 404
            raise HttpErrors::ResourceNotFoundError, env
          when 400...500
            raise HttpErrors::ClientError, env
          when 500...600
            raise HttpErrors::ServerError, env
          end
        end

        Faraday::Response.register_middleware(kassa_handle_http_error: self)
      end
    end
  end
end
