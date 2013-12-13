require 'sinatra'
require 'erb'
require 'net/http'
require 'uri'
require 'json'
include ERB::Util

get '/' do
	erb :search
end

post '/' do
	content_type :json
	@query="http://api.nytimes.com/svc/search/v2/articlesearch.json?fq="+url_encode(params[:followup])+"&facet_field=day_of_week&begin_date=20120101&end_date=20131205&$pub_date&api-key=88192c1ed8fcf241f009ec9b0516d6ee:18:40073815"

	uri = URI.parse(@query)
	response = Net::HTTP.get_response(uri)
	@json_data = JSON.parse(response.body)

	content_type :html
	@json_data
	erb :results, :locals => {:data => @json_data}
end





