require 'mercadopago/utils/hash'

module Mercadopago
  module Endpoint
    class Base
      attr_reader :data, :rest_client

      def initialize(rest_client, data)
        @rest_client = rest_client
        # validate_data(@data, mandatory_keys)
        @data = data
      end


      def to_s
        self.class.to_s.split("::").last.downcase
      end

      protected
      def member_endpoint
        id = data[:id] || raise(StandardError.new('Unknown ID'))
        "#{ENDPOINT}/#{id}"
      end

      private
      def validate_data(h, keys)
        unless keys.all?{|k| check_mandatory_keys(h, k) }
          raise(Error::BadRequest.new('Missing data.
            Mandatory keys: #{mandatory_keys}'))
        end
      end

      def check_mandatory_keys(h, k)
        if k.is_a?(Symbol) || k.is_a?(String)
          h[k]
        elsif k.is_a?(Array)
          k.all?{ |key| h[key]}
        elsif k.is_a?(Hash)
          k.all?{|key, value| check_mandatory_keys(h[key], value) }
        end
      end

    end
  end
end
