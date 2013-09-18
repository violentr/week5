require 'sinatra'
require_relative 'fizzbuzz'

get '/fizzbuzz' do
	erb :fizzbuzz
end

get '/fizzbuzz/fizz' do
	max = params[:max_number].to_i #hash returns string ,but must return number
	@fizzbuzz = FizzBuzz.new.value_for(max)
	@color =FizzBuzz.color(@fizzbuzz)
	@your_number = params[:max_number]
	erb :fizzbuzz_result
end