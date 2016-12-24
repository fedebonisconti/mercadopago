module Mercadopago
  module Endpoint
    class Preference < Base
      ENDPOINT = "/checkout/preferences".freeze

      def get
        rest_client.get(member_endpoint)
      end

      def create
        rest_client.post(ENDPOINT, data)
      end

      def update
        rest_client.update(ENDPOINT, data)
      end
    end
  end
end
