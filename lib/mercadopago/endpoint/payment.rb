module Mercadopago
  module Endpoint
    class Payment < Base
      ENDPOINT = "/payments"
      COLLECTIONS = "/collections/"

      def get
        endpoint = ENDPOINT
        endpoint += COLLECTIONS + "notifications/" + data[:id] if data[:id]
        rest_client.get(endpoint)
      end

      def charge
        rest_client.post(ENDPOINT, data)
      end

      def refund
        rest_client.put(COLLECTIONS + data[:id])
      end

      def cancel
        rest_client.put(COLLECTIONS + params[:id])
      end

      def mandatory_keys
        [:transaction_amount, :token, :description, :installments,
          :payment_method_id, payer: [:email] ]
      end

    end
  end
end
