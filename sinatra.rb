require 'sinatra'
require './api/crypto'

get '/' do
  @base_url = Crypto.base_url
  Crypto.refresh
  @data = Crypto.payload
  erb :index, :format => :html5
end