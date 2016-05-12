module Mercadopago
  module Config
    module Env
      extend self

      def environment
        return Rails.env if defined?(Rails) && Rails.respond_to?(:env)
        return Sinatra::Base.environment.to_s if defined?(Sinatra)
        ENV['MERCADOPAGO_ENV'] || ENV['ENVIRONMENT'] ||
        raise(Errors::NoEnvironment.new)
      end

      def development?
        (defined?(Rails) && Rails.env.development?) ||
        ENV['ENVIRONMENT'] == "development" ||
        ENV['MERCADOPAGO_ENV'] == "development"
      end

      def test?
        (defined?(Rails) && Rails.env.test?) ||
        ENV['ENVIRONMENT'] == "test" ||
        ENV['MERCADOPAGO_ENV'] == "test"
      end

      def production?
        (defined?(Rails) && Rails.env.production?) ||
        ENV['ENVIRONMENT'] == "production" ||
        ENV['MERCADOPAGO_ENV'] == "production"
      end

    end
  end
end
