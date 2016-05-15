require "mercadopago/rest_client"
require "mercadopago/endpoint/base"
require "mercadopago/endpoint/payment"

module Mercadopago
  class Client
    attr_accessor :rest_client

    extend Forwardable

    def_delegators :@rest_client, :sandbox_mode,
      :access_token, :client_id, :client_secret


    def initialize(opts = {})
      @rest_client ||= RestClient.new(opts)
    end

    def payment(method, data)
      call_operation(Endpoint::Payment, data, method)
    end

    def subscribe(method, data)
      call_operation(Endpoint::Subscription, data, method)
    end


    private
    def call_operation(klazz, data, method)
      op = klazz.new(rest_client, data)
      op.public_send(method) if op.respond_to?(method) ||
        raise(Errors::Endpoint.new('Invalid endpoint'))
    end
  end
end
