module Mercadopago
  module Endpoint
    class Base
      attr_reader :data, :rest_client

      def initialize(rest_client, data)
        @rest_client = rest_client
        @data = data
      end

      def to_s
        self.class.to_s.split("::").last.downcase
      end

      protected
      def member_endpoint
        id = data[:id] || raise(StandardError.new('Unknown ID'))
        "#{self.class::ENDPOINT}/#{id}"
      end

    end
  end
end
