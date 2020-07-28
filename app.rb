require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry-byebug'
require 'better_errors'

require_relative './lib/recipe'
require_relative './lib/cookbook'

set :bind, '0.0.0.0'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  csv_file = File.join(__dir__, '/lib/recipes.csv')
  @cookbook = Cookbook.new(csv_file)
  erb :index
end

get '/new' do
  erb :create
end

post '/recipes' do
  csv_file = File.join(__dir__, '/lib/recipes.csv')
  @cookbook = Cookbook.new(csv_file)

  name = params[:name]
  description = params[:description]
  prep_time = params[:prep_time]
  skill_level = params[:skill_level]

  @cookbook.add_recipe(Recipe.new(name, description, prep_time, skill_level))

  redirect '/'
end

get '/destroy/:index' do
  # binding.pry
  recipe_index = params[:index].to_i

  csv_file = File.join(__dir__, '/lib/recipes.csv')
  @cookbook = Cookbook.new(csv_file)
  @cookbook.remove_recipe(recipe_index)

  redirect '/'
end
