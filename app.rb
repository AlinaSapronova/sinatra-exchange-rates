require "sinatra"
require "sinatra/reloader"
require 'net/http'
require 'json'



get("/") do
url = "https://api.exchangerate.host/symbols"
uri = URI(url)
response = Net::HTTP.get(uri)
response_obj = JSON.parse(response)
@symbols = response_obj.fetch("symbols")
erb(:home)
end

get("/USD") do
url = "https://api.exchangerate.host/symbols"
uri = URI(url)
response = Net::HTTP.get(uri)
response_obj = JSON.parse(response)
@symbols = response_obj.fetch("symbols")
erb(:convert_usd)
end


# get("/INR") do
# url = "https://api.exchangerate.host/symbols"
# uri = URI(url)
# response = Net::HTTP.get(uri)
# response_obj = JSON.parse(response)
# @symbols = response_obj.fetch("symbols")
# erb(:convert_inr)
# end

# get("/KES") do
# url = "https://api.exchangerate.host/symbols"
# uri = URI(url)
# response = Net::HTTP.get(uri)
# response_obj = JSON.parse(response)
# @symbols = response_obj.fetch("symbols")
# erb(:convert_kes)
# end



get("/:from/:to") do
  convert_url  = "https://api.exchangerate.host/convert?from=USD&to=EUR"
  convert_uri = URI(convert_url)
  convert_response = Net::HTTP.get(convert_uri)
  conv_response_obj = JSON.parse(convert_response)
  currency = conv_response_obj.fetch("query")
  @from = currency.fetch("from")
  @to = currency.fetch("to")
  @result = conv_response_obj.fetch("result")

  erb(:convert)
end
