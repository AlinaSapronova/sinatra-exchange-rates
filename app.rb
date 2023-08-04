require "sinatra"
require "sinatra/reloader"
require 'net/http'
require 'json'



convert_url  = "https://api.exchangerate.host/convert?from=USD&to=EUR"
convert_uri = URI(convert_url)
convert_response = Net::HTTP.get(convert_uri)
conv_response_obj = JSON.parse(convert_response)


get("/") do
url = "https://api.exchangerate.host/symbols"
uri = URI(url)
response = Net::HTTP.get(uri)
response_obj = JSON.parse(response)
@symbols = response_obj.fetch("symbols")
erb(:home)
end

get("/:symbol") do
  url = "https://api.exchangerate.host/symbols"
uri = URI(url)
response = Net::HTTP.get(uri)
response_obj = JSON.parse(response)
  @symbol_name = response_obj.fetch("symbols")
end
