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
        end
      end
    end
  end
end
