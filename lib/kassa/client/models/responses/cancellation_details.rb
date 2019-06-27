module Kassa
  class Client
    module Models
      module Responses
        class CancellationDetails < Base
          property :party
          property :reason
        end
      end
    end
  end
end
