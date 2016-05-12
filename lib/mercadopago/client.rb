module Mercadopago
  class Client
    attr_accessor :client_id, :client_secret, :sandbox_mode

    def initialize
      @client_id = ::Mercadopago.client_id
      @client_secret = ::Mercadopago.client_secret
      @sandbox_mode = ::Mercadopago.sandbox_mode
    end

    def charge
    end
  end
end
