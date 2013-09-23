# require 'open-uri'
# file = open('http://zaycev.net/download.php?id=2056')
# contents = file.read
# puts contents

require 'sinatra'
require 'open-uri'
#file_contents = open('local-file.txt') { |f| f.read }
get '/' do
#s = 'users/login'
@message = 'Peace off'


web_contents  = open('http://www.apple.com/iphone-5c/') {|f| f.read }
@iphone_there = web_contents.include?("available")
#@iphone_there =web_contents.match /iphone/i
@message = "Get it" if @iphone_there  # @message = "Peace off" if false

erb :report
end

# get '/:something' do |something|
# 	if(100...12000).include? params[:id].to_i
# 	  return "You got files"
# 	else
# 		return "no file for you"
# 	end

# end

helpers do
	def message_to_user(message)
		"<p>#{@message}</p>"
	end
end