module Kassa
  class Client
    module Models
      module Requests
        class Confirmation < Base
          property :type
          property :locale
          property :enforce, default: true
          property :return_url
        end
      end
    end
  end
end
