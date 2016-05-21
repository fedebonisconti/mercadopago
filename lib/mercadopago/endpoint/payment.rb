module Mercadopago
  module Endpoint
    class Payment < Base
      ENDPOINT = "/payments"

      def get
        endpoint = data[:id] ? member_endpoint : ENDPOINT
        rest_client.get(endpoint)
      end

      def charge
        rest_client.post(ENDPOINT, data)
      end

      def refund
        rest_client.put(member_endpoint + "/refunds")
      end

      def cancel
        rest_client.put(member_endpoint, {status: "cancelled"})
      end

      def search
        rest_client.get(ENDPOINT + "/search", data[:filters])
      end

      def mandatory_keys
        [:transaction_amount, :token, :description, :installments,
          :payment_method_id, payer: [:email] ]
      end

    end
  end
end
