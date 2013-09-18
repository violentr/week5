require 'sinatra'

get '/' do
request.env.map { |e| e.to_s + "\n" }
end
# get '/' do
# 	@name = 'Deniss'
# 	"Hello " + @name
# end

# get '/:name' do |name|
# 	@name = %w(Lorraine Jodie  Yuin Paolo).sample 
# 	erb :index
# end

get '/hello' do 
	@name = %w(Lorraine Jodie  Yuin Paolo).sample

	@visitor = params[:name]
	erb :index
end