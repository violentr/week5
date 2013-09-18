require 'sinatra'
require './lib/sudoku'
require './lib/cell'
 
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

#this method removes some digits from the solution to create puzzle 
def puzzle(sudoku)
#this method is yours to implement
#need to remove 2 numbers from grid
	sudoku[9]=0
	sudoku[5]=0
	
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

get '/hello/:name' do |n|

end

get '/' do
	prepare_to_check_solution
	generate_new_puzzle_if_necessary
	@current_solution = session[:current_solution] || session[:puzzle]
	sudoku = random_sudoku
	session[:solution] =sudoku
	@current_solution =puzzle(sudoku)
	erb :index
end

get '/solution' do
	@solution=session[:solution]
	@puzzle =session[:puzzle]
	erb :index
end

post '/' do
	cells = params["cell"]
	session[:current_solution] = cells.map{|value| value.to_i}.join
	session[:check_solution] =true
	#redirect to("/")
end

















