require 'httparty'

class Crypto

  @@base_url = "https://www.cryptocompare.com/"

  @@coins = ["BTC","ETH","BCH","XRP","LTC","ADA","IOT","DASH","XEM","XMR","BTG","XLM","EOS","NEO","ETC","TRX","BCCOIN","QTUM","PPT","OMG"]

  @@coin_info_endpoint = "https://www.cryptocompare.com/api/data/coinlist/"

  @@coins_data = HTTParty.get(@@coin_info_endpoint)["Data"]

  # note USD is hard-coded as the to-currency
  @@price_info_endpoint = "https://min-api.cryptocompare.com/data/pricemulti?fsyms=#{@@coins.join(',')}&tsyms=USD"

  @@price_data = HTTParty.get(@@price_info_endpoint)

  def self.payload
    result = []
    @@coins.each do |coin|
      result << Crypto.new(coin)
    end
    return result
  end

  def self.coins_data
    # returns json where
    # each key is the coin symbol of type string
    # relies on limited set of @@coins
    # example:
    # data = Crypto.coins_data
    # data["BTC"]   <= returns bitcoin data

    return @@coins_data
  end

  def self.price_data
    return @@price_data
  end

  def self.base_url
    return @@base_url
  end

  def initialize(coin_symbol)
    # coin_symbol (String)
    #   example: Crypto.new("BTC")
    @symbol = coin_symbol.upcase
    @data = Crypto.coins_data[coin_symbol]
    @price = Crypto.price_data[coin_symbol]["USD"]
  end

  def data
    @data
  end

  def symbol
    @symbol
  end

  def price
    @price
  end
end

p Crypto.payload