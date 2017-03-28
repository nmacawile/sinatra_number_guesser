require "sinatra"
require 'sinatra/reloader'

number = rand(101)

get("/"){ erb(:index, :locals => { :number => number }) }