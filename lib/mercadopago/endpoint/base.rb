require 'mercadopago/utils/hash'

module Mercadopago
  module Endpoint
    class Base
      attr_reader :data, :rest_client

      def initialize(rest_client, data)
        @rest_client = rest_client
        @data = data
        # @data = Utils::Hash.new(data)
        # verify_data(@data, mandatory_keys)
      end


      def to_s
        self.class.to_s.split("::").last.downcase
      end

      private
      def verify_data(h, *keys)
        raise(Error::BadRequest.new('Missing data')) unless keys.all? do |k, v|
          verify_data(h[k], v) if v.kind_of?(Hash)
        end
      end

    end
  end
end
