module Mercadopago
  module Endpoint
    class PaymentMethods < Base
      ENDPOINT = "/v1/payment_methods".freeze

      def get
        rest_client.get(ENDPOINT)
      end
    end
  end
end
