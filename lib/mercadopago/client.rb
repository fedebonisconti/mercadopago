require "forwardable"
require "mercadopago/rest_client"
require "mercadopago/endpoint"

module Mercadopago
  class Client
    extend Forwardable

    attr_accessor :rest_client

    def_delegators :@rest_client, :access_token, :public_key, :get, :post,
      :put, :delete


    def initialize(opts = {})
      @rest_client = RestClient.new(opts)
    end

    # This method provides interaction with payment's API endpoint
    def payment(method, data = {})
      call_endpoint(Endpoint::Payment, method, data)
    end

    # This method provides interaction with payment methods's API endpoint
    def payment_methods(method, data = {})
      call_endpoint(Endpoint::PaymentMethods, method, data)
    end


    private
    def call_endpoint(klazz, method, data)
      op = klazz.new(rest_client, data)
      op.public_send(method) if op.respond_to?(method) ||
        raise(Errors::Endpoint.new('Invalid endpoint method'))
    end
  end
end
