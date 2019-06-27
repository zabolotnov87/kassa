module Kassa
  class Client
    module Models
      module Responses
        class Payment < Base
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
        end
      end
    end
  end
end
