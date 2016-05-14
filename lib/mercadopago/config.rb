require 'mercadopago/config/env'

module Mercadopago
  module Config
    extend self

    def access_token
      (secrets && secrets['access_token']) ||
      ENV['MERCADOPAGO_ACCESS_TOKEN'] ||
      raise(Errors::CredentialNotFound.new('Access Token not found'))
    end

    def public_key
      (secrets && secrets['public_key']) ||
      ENV['MERCADOPAGO_PUBLIC_KEY'] ||
      raise(Errors::CredentialNotFound.new('Public Key not found'))
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
