require 'mercadopago/config/env'
require 'mercadopago/config/options'

module Mercadopago
  module Config
    extend self
    extend Options

    def configured?
      ["secret_id", "client_secret",
        "access_token"].all?{ |k| settings.has_key?(k) }
    end
  end
end
