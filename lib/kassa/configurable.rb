module Kassa
  module Configurable
    CONFIGURATION_OPTIONS = %i[
      api_endpoint
      account_id
      secret_key
      logger
      open_timeout
      read_timeout
    ].freeze

    DEFAULTS_READ_TIMEOUT = 5
    DEFAULTS_OPEN_TIMEOUT = 2

    attr_accessor(*CONFIGURATION_OPTIONS)

    def configure
      yield self
      set_defaults
    end

    def set_defaults
      self.read_timeout ||= DEFAULTS_READ_TIMEOUT
      self.open_timeout ||= DEFAULTS_OPEN_TIMEOUT
    end

    def options
      Hash[CONFIGURATION_OPTIONS.map { |attr| [attr, send(attr)] }]
    end

    def same_options?(options)
      self.options.hash == options.hash
    end
  end
end
