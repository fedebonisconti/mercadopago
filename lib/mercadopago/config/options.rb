module Mercadopago
  module Config
    module Options
      def defaults
        @defaults ||= {}
      end

      def reset
        settings.replace(defaults)
      end

      def settings
        @settings ||= {}
      end
    end
  end
end
