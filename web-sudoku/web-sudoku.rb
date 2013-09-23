require 'sinatra'
require './lib/sudoku'
require './lib/cell'
require 'rack-flash'
require 'newrelic_rpm'
use Rack::Flash

# enable :sessions # sessions are disabled by default 
 
# get '/' do
#   # save the current time into session
#   session[:last_visit] = Time.now.to_s 
#   "Last visit time has been recorded"
# end 
 
# get '/last-visit' do
#   # get the last visited time from the session
#   "Previous visit to homepage: #{session[:last_visit]}"
# end
# If you want to delete something from a session, simply set it to nil.
# session[:last_visit] = nil
enable :sessions
set :session_secret, "I'm the secret key to sign the cookie"
def random_sudoku
	#we are using 9 numbers ,1 to 9 ,and 72 zeros as an input
	# it is obvious there may be no clashes as all numbers are unique
	seed = (1..9).to_a.shuffle + Array.new(81-9,0)
	sudoku = Sudoku.new(seed.join)
	#then we solve this (really hard!) sudoku
	sudoku.solve!
	#and give the output to the view as an array of chars
	sudoku.to_s.chars
end
def generate_new_puzzle_if_necessary
	return if session[:current_solution]
	sudoku=random_sudoku
	session[:solution] =sudoku
	session[:puzzle] =puzzle(sudoku)
	session[:current_solution]=session[:puzzle]
end
def prepare_to_check_solution
	@check_solution =session[:check_solution]
	session[:check_solution] =nil
end

helpers do

  def colour_class(solution_to_check, puzzle_value, current_solution_value, solution_value)
    must_be_guessed = puzzle_value.to_i == 0
    tried_to_guess = current_solution_value.to_i != 0
    guessed_incorrectly = current_solution_value.to_i != solution_value.to_i

    if solution_to_check && 
        must_be_guessed && 
        tried_to_guess && 
        guessed_incorrectly
      'incorrect'
    elsif !must_be_guessed
      'value-provided'

    end
  end
end
helpers do
  def cell_value(value)
    value.to_i == 0 ? '' : value
  end
end

#this method removes some digits from the solution to create puzzle 
def puzzle(sudoku)
#this method is yours to implement
#need to remove 2 numbers from grid
sudoku =sudoku.dup
# [10,20,30,40,23,45,56,76,34,56,77,21].each do |index| 
(1.upto(81).to_a.shuffle.slice(0,25)).each do |index|
 sudoku[index]=''
end
 # random_values =Array.new(10.upto(37).to_a).shuffle
	# random.values.each {|index| sudoku[index] =''}
	# sudoku[9]=0
	# sudoku[5]=0
	sudoku
end

get '/solution' do
	@current_solution=session[:solution]
	@solution=session[:solution]
	@puzzle =session[:puzzle]
	erb :index
end

get '/reset' do
# session.delete(:current_solution)
session[:solution]=nil
session[:puzzle]=nil
session[:current_solution]=nil
redirect to('/')
end

post '/' do
  session[:current_solution] = params["cell"]
  session[:check_solution] = true
  redirect to("/")
end

get '/' do
	prepare_to_check_solution
	generate_new_puzzle_if_necessary
	@current_solution = session[:current_solution] || session[:puzzle]
	@solution = session[:solution]
	@puzzle = session[:puzzle]
	erb :index
end

def prepare_to_check_solution
  @check_solution = session[:check_solution]
  if @check_solution
    flash[:notice] = "Incorrect values are highlighted in yellow"
  end
  session[:check_solution] = nil
end
# get '/hello/:name' do |n|
# end
























