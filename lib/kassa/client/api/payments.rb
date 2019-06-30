module Kassa
  class Client
    module Api
      module Payments
        IDEMPOTANCE_KEY_HEADER = 'Idempotence-Key'.freeze
        CREATE_PAYMENTS_PATH = 'payments'.freeze
        READ_PAYMENTS_PATH = 'payments/{id}'.freeze

        # @param payment [Kassa::Requests::Payment]
        # @return [Kassa::Responses::Payment]
        #
        def create_payment(payment, idempotence_key:)
          headers = build_idempotence_key_header(idempotence_key)
          response = http_post(CREATE_PAYMENTS_PATH, params: payment, headers: headers)
          json = JSON.parse(response.body)
          Responses::Payment.new(json)
        end

        # @param id [String]
        # @return [Kassa::Responses::Payment]
        #
        def payment(id)
          read_payments_path =
            Addressable::Template.new(READ_PAYMENTS_PATH).expand(id: id)
          response = http_get(read_payments_path)
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

      include Payments
    end
  end
end
