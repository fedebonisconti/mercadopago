require "mercadopago/rest_client"
require "mercadopago/endpoint"

module Mercadopago
  class Client
    attr_accessor :rest_client

    extend Forwardable

    def_delegators :@rest_client, :sandbox_mode,
      :access_token, :public_key


    def initialize(opts = {})
      @rest_client = RestClient.new(opts)
    end

    # This method provides interaction with payment's API endpoint
    def payment(method, data)
      call_endpoint(Endpoint::Payment, method, data)
    end

    # This method provides interaction with subcription's API endpoint
    def subscribe(method, data)
      call_endpoint(Endpoint::Subscription, method, data)
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
