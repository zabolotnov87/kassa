require_relative 'models/requests/base'
require_relative 'models/requests/amount'
require_relative 'models/requests/confirmation'
require_relative 'models/requests/payment'

require_relative 'models/responses/base'
require_relative 'models/responses/payment'

module Kassa
  Requests = Client::Models::Requests
  Responses = Client::Models::Responses
end
