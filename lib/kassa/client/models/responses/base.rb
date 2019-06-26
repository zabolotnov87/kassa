module Kassa
  class Client
    module Models
      module Responses
        class Base < Hashie::Trash
          include Hashie::Extensions::IgnoreUndeclared
          include Hashie::Extensions::Dash::IndifferentAccess
          include Hashie::Extensions::Dash::Coercion
        end
      end
    end
  end
end
