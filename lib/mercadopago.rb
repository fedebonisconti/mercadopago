require "mercadopago/version"
require "mercadopago/client"
require "mercadopago/errors"
require "mercadopago/config"


# Add es load path by default
if defined?(I18n)
  I18n.load_path << File.join(File.dirname(__FILE__),
    "config", "locales", "es.yml")
end

module Mercadopago
  extend self

  def configure
    yield self
  end

  def client
    Client.new
  end
end
