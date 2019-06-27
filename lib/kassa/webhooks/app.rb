module Kassa
  module Webhooks
    class App
      OK_STATUS_CODE = 200
      OK_BODY = 'OK'.freeze

      attr_reader :logger, :process_notification

      # @param logger [Logger]
      #
      def initialize(logger = Kassa.logger, &process_notification)
        @logger = logger
        @process_notification = process_notification
      end

      def call(env)
        request = Rack::Request.new(env)
        body = JSON.parse(request.body.read)
        logger.debug("Incoming request: #{body}")
        notification = Models::Notification.new(body)
        process_notification.call(notification)
        Rack::Response.new(OK_BODY, OK_STATUS_CODE)
      end
    end
  end
end
