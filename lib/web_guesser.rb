require "sinatra"
require 'sinatra/reloader'

#SECRET_NUMBER = rand(101)
set :secret_number, rand(101)

get("/") do
	guess = params["guess"]
  	message = check_guess(guess)
	erb(:index, :locals => { :number => settings.secret_number, :message => message })
end

def check_guess(guess)
	return "Guess the secret number. (1 to 100)" if guess.nil? || guess.match(/^\s*$/)
	result = settings.secret_number - guess.to_i

	if result.between?(6, 100)
		"WAY TOO LOW!"
	elsif result.between?(1, 5)
		"TOO LOW!"
	elsif result == 0
		"YOU GOT IT RIGHT! The Secret number is #{settings.secret_number}!!"
	elsif result.between?(-5, -1)
		"TOO HIGH!"
	else
		"WAY TOO HIGH!"
	end

end