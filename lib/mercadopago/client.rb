require "mercadopago/rest_client"
require "mercadopago/operation/base"
require "mercadopago/operation/payment"

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
      call_operation(Operation::Payment.new(rest_client, data), method)
    end

    def subscribe(method, data)
      call_operation(Operation::Subscription.new(rest_client, data), method)
    end


    private
    def call_operation(op, method)
      op.public_send(method) if op.respond_to?(method) ||
        raise(Errors::Operation.new('Invalid operation'))
    end
  end
end
