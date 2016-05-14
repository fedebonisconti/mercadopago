require 'mercadopago/config/env'

module Mercadopago
  module Config
    extend self

    def access_token
      (secrets && secrets['access_token']) ||
      ENV['MERCADOPAGO_ACCESS_TOKEN'] ||
      raise(Errors::CredentialNotFound.new('Access Token not found'))
    end

    def client_id
      (secrets && secrets['client_id']) ||
      ENV['MERCADOPAGO_CLIENT_ID'] ||
      raise(Errors::CredentialNotFound.new('Client ID not found'))
    end

    def client_secret
      # (secrets && secrets['client_secret']) ||
      # ENV['MERCADOPAGO_CLIENT_SECRET'] ||
      # raise(Errors::CredentialNotFound.new('Client Secret not found'))
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
