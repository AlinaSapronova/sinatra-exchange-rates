require "sinatra"
require "sinatra/reloader"
require 'net/http'
require 'json'

def fetch_symbols
  url = "https://api.exchangerate.host/symbols"
  uri = URI(url)
  response = Net::HTTP.get(uri)
  response_obj = JSON.parse(response)
  symbols_hash = response_obj.fetch("symbols")
  list_of_symbols = symbols_hash.keys

  return list_of_symbols
end


get("/") do

  @symbols = fetch_symbols

  erb(:home)
end

get("/:from") do

  @symbols = fetch_symbols

  erb(:convert)
end


get("/:from/:to") do

  @symbols = fetch_symbols

  url = "https://api.exchangerate.host/convert?from=#{params.fetch("from")}&to=#{params.fetch("to")}"
  uri = URI(url)
  response = Net::HTTP.get(uri)
  response_obj = JSON.parse(response)
  @rate = response_obj.fetch("info").fetch("rate")

 erb(:convert_currency)
end
