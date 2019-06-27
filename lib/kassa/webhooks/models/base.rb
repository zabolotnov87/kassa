module Kassa
  module Webhooks
    module Models
      class Base < Hashie::Trash
        include Hashie::Extensions::IgnoreUndeclared
        include Hashie::Extensions::Dash::IndifferentAccess
        include Hashie::Extensions::Dash::Coercion
      end
    end
  end
end
