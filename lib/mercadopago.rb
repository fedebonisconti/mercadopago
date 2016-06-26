require "mercadopago/version"
require "mercadopago/client"
require "mercadopago/errors"
require "mercadopago/endpoint"
require "mercadopago/config"


module Mercadopago
  extend self

  def configure
    yield Config
  end

  def client(opts = {})
    Client.new(opts)
  end
end
