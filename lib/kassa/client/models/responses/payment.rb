module Kassa
  class Client
    module Models
      module Responses
        class Payment < Base
          SUCCEEDED_STATUS = 'succeeded'.freeze
          CANCELED_STATUS = 'canceled'.freeze
          WAITING_FOR_CAPTURE_STATUS = 'waiting_for_capture'.freeze

          property :id
          property :status
          property :confirmation_url,
                   from: 'confirmation',
                   transform_with: ->(data) { data[:confirmation_url] if data }
          property :captured_at,
                   transform_with: ->(captured_at) { Time.parse(captured_at) }
          property :test
          property :paid
          property :cancellation_details, coerce: CancellationDetails

          alias paid? paid
          alias test? test

          def succeeded?
            status == SUCCEEDED_STATUS
          end

          def canceled?
            status == CANCELED_STATUS
          end

          def waiting_for_capture?
            status == WAITING_FOR_CAPTURE_STATUS
          end
        end
      end
    end
  end
end
