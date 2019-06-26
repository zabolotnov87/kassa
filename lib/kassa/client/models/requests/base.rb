module Kassa
  class Client
    module Models
      module Requests
        class Base < Hashie::Trash
          include Hashie::Extensions::Dash::IndifferentAccess
          include Hashie::Extensions::Dash::Coercion
        end
      end
    end
  end
end
