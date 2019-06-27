module Kassa
  module Webhooks
    module Models
      class Notification < Base
        PAYMENT_TYPE = 'payment'.freeze
        REFUND_TYPE = 'refund'.freeze
        SUCCEEDED_STATUS = 'succeeded'.freeze
        CANCELED_STATUS = 'canceled'.freeze
        WAITING_FOR_CAPTURE_STATUS = 'waiting_for_capture'.freeze

        property :event
        property :object_id,
                 from: 'object',
                 transform_with: ->(data) { data[:id] }

        def payment?
          object_type == PAYMENT_TYPE
        end

        def refund?
          object_type == refund
        end

        def succeeded?
          event_status == SUCCEEDED_STATUS
        end

        def canceled?
          event_status == CANCELED_STATUS
        end

        def waiting_for_capture?
          event_status == WAITING_FOR_CAPTURE_STATUS
        end

        private

        def object_type
          event.split('.').first
        end

        def event_status
          event.split('.').last
        end
      end
    end
  end
end
