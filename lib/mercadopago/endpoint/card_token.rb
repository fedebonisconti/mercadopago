module Mercadopago
  module Endpoint
    class CardToken < Base
      ENDPOINT = "/v1/card_tokens".freeze

      def get
        rest_client.get(member_endpoint)
      end

      def create
        rest_client.post(ENDPOINT, data)
      end

      def update
        rest_client.put(ENDPOINT, data)
      end
    end
  end
end
