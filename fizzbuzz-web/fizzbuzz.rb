
class FizzBuzz
	def value_for(number)
		if is_divisible_by_15?(number) #must be first in a list, as it checks for 15 at once
			"FizzBuzz"
		elsif is_divisible_by_3?(number)# checks 
			"Fizz"

		elsif is_divisible_by_5?(number)
			"Buzz" # = same as return "Buzz"
		else
			number
		end
	end

	def is_divisible_by_3?(number)
 		number % 3 == 0

 	end

	def is_divisible_by_5?(number)
		number % 5 == 0
 	end

 	def is_divisible_by_15?(number)
 		number % 15 == 0
 	end

 	def self.color(input)
 		case input
 		when "FizzBuzz"
 			"color:green"
 		when "Fizz"
 			"color:black"
 		when "Buzz"
 			"color:red"
 		else
 			"color:blue"
 		end
 	end
end

# puts fizzbuzz =FizzBuzz.new.value_for(5)