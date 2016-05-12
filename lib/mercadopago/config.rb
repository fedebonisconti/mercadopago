require 'mercadopago/config/env'
require 'mercadopago/config/options'

module Mercadopago
  module Config
    extend self
    extend Options

    def access_token
      (secrets && secrets['access_token']) ||
      ENV['MERCADOPAGO_ACCESS_TOKEN'] || raise Errors::CredentialNotFound
    end

    def client_id
      (secrets && secrets['client_id']) ||
      ENV['MERCADOPAGO_CLIENT_ID'] || raise Errors::CredentialNotFound
    end

    def client_secret
      (secrets && secrets['client_secret']) ||
      ENV['MERCADOPAGO_CLIENT_SECRET'] || raise Errors::CredentialNotFound
    end

    def sandbox_mode
      (secrets && secrets['sandbox_mode']) ||
      ENV['MERCADOPAGO_SANDBOX_MODE']
    end

    private
    def secrets
      @secrets ||= ::Rails.application.secrets.mercadopago if defined?(::Rails)
    end

  end
end
