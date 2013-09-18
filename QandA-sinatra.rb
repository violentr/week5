require 'sinatra'
# Sianatra is a framework to build web app in ruby.
#hello.rb
get '/' do #get path and a block
	"hello"
end

create folder "views"
create a file  views/index.erb

#hello.rb
require 'sinatra'
get '/' do
	erb: index --> 'index.erb' and checks for a file index.erb in a "views" dir
end

get '/:age' do |age|
 "You are #{age} old"
end

get '/:name/:age' do |name, age|
 "#{name} you are #{age} old "
end