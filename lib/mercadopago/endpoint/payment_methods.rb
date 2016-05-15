module Mercadopago
  module Endpoint
    class PaymentMethods < Base
      ENDPOINT = "/payment_methods"

      def get
        rest_client.get(ENDPOINT)
      end

    end
  end
end
