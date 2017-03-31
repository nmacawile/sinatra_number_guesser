require "sinatra"
require 'sinatra/reloader'

set :secret_number, rand(101)
@@attempts = 3

get "/" do
	guess = params["guess"]
	cheat = params["cheat"]
	difference = check_guess(guess)
	color = change_color(difference)
  	message = generate_message(difference, settings.secret_number)
  	generate_number(difference)
	erb(:index, :locals => { :number => settings.secret_number, :message => message, :color => color, :guesses => @@attempts, :cheat => cheat })
end

def generate_number(diff)
	return if diff == nil
	if @@attempts == 1 || diff == 0
		settings.secret_number = rand(101)
		@@attempts = 3
	else
		@@attempts -= 1
	end
end

def check_guess(guess)
	return if guess.nil? || guess.match(/^\s*$/)
	settings.secret_number - guess.to_i
end

def generate_message(diff, current_number)
	return "Guess the secret number. (1 to 100)" if diff.nil?
	return "YOU GOT IT RIGHT! The Secret number is #{current_number}!!" if diff == 0
	return "You lost. The number was #{current_number}. A new number has been generated." if @@attempts == 1

	if diff.between?(6, 100) then return "WAY TOO LOW! You have #{@@attempts - 1} attempts."
	elsif diff.between?(1, 5) then return "TOO LOW! You have #{@@attempts - 1} attempts."	
	elsif diff.between?(-5, -1) then return "TOO HIGH! You have #{@@attempts - 1} attempts."
	else return "WAY TOO HIGH! You have #{@@attempts - 1} attempts."
	end
end

def change_color(difference)
	return "WHITE" if difference.nil?
	return "green" if difference == 0
	return "RED" if @@attempts == 1
	difference = difference.abs	
	offset = 100 - difference
	"rgb(255, #{offset}, #{offset})"
end
