module Mercadopago
  module Operation
    class Payment < Base
      ENDPOINT = "/v1/payments"

      def get(id)

      end

      def charge
        rest_client.post(ENDPOINT, data)
      end

      def refund

      end

      def mandatory_keys
        [:transaction_amount, :token, :description, :installments,
          :payment_method_id, payer: [:email] ]
      end

    end
  end
end
