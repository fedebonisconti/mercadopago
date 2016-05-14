module Mercadopago
  module Utils
    class Hash < ::Hash
      def [](key)
        super(key.to_sym) || super(key.to_s)
      end

      def method_missing(name, *args, &block)
        if v = nested_value(name)
          v
        else
          super
        end
      end

      def nested_value(key, obj = self)
        if obj.respond_to?(:has_key?) && obj.has_key?(key)
          obj[key]
        elsif obj.kind_of?(Enumerable)
          r = nil
          obj.find{ |*a| r = nested_hash_value(key, a.last) }
          r
        end
      end
    end
  end
end
