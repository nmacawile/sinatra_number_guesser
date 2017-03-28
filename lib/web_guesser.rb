require "sinatra"
require 'sinatra/reloader'

number = rand(101)

get("/"){ "The SECRET NUMBER is #{number}." }