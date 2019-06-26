module Kassa
  class Client
    module Api
      IDEMPOTANCE_KEY_HEADER = 'Idempotence-Key'.freeze
      PAYMENTS_PATH = 'payments'.freeze

      # @param payment [Kassa::Requests::Payment]
      # @return [Kassa::Responses::Payment]
      #
      def create_payment(payment, idempotence_key:)
        headers = build_idempotence_key_header(idempotence_key)
        response = http_post(PAYMENTS_PATH, params: payment, headers: headers)
        json = JSON.parse(response.body)
        Responses::Payment.new(json)
      end

      private

      def build_idempotence_key_header(key)
        {
          IDEMPOTANCE_KEY_HEADER => key,
        }
      end
    end
  end
end
