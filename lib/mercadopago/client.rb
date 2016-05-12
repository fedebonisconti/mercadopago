require "mercadopago/rest_client"

module Mercadopago
  class Client
    attr_accessor :access_token, :client_id, :client_secret,
      :sandbox_mode, :rest_client

    def initialize(opts = {})
      config = ::Mercadopago::Config
      @access_token = opts[:access_token] || config.access_token
      @client_id = opts[:client_id] || config.access_token
      @client_secret = opts[:client_secret] || config.client_secret
      @sandbox_mode = opts[:sandbox_mode] || config.sandbox_mode || true
    end

    def charge
    end

    def rest_client
      @rest_client ||= RestClient.new
    end
  end
end
