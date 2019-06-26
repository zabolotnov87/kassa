module Kassa
  class Client
    module Models
      module Requests
        class Amount < Base
          property :value
          property :currency
        end
      end
    end
  end
end
