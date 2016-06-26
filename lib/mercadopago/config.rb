require 'mercadopago/config/env'

module Mercadopago
  module Config
    extend self
    attr_accessor :access_token, :public_key, :sandbox_mode
    attr_reader :secrets

    def access_token
      @access_token ||= secrets('access_token') ||
      ENV['MERCADOPAGO_ACCESS_TOKEN'] ||
      raise(Errors::CredentialNotFound.new('Access Token not found'))
    end

    def public_key
      @public_key ||= secrets('public_key') ||
      ENV['MERCADOPAGO_PUBLIC_KEY'] ||
      raise(Errors::CredentialNotFound.new('Public Key not found'))
    end

    def sandbox_mode
      if @sandbox_mode.nil?
        @sandbox_mode = secrets('sandbox_mode') ||
        ENV['MERCADOPAGO_LIVE_MODE'] || true
      end
      @sandbox_mode
    end

    def reset!
      @access_token = (@public_key = (@sandbox_mode = nil))
    end

    private
    def secrets(key = nil)
      if defined?(::Rails)
        @secrets ||= ::Rails.application.secrets.mercadopago
        (@secrets && key && @secrets[key]) || @secrets
      end
    end

  end
end
