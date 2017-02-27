require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/truck.rb' )

get '/trucks' do
  @trucks = Truck.all()
  erb ( :"trucks/index" )
end

get '/trucks/new' do
  erb(:"trucks/new")
  end

  post '/trucks' do
  @truck = Truck.new(params)
  @truck.save
  redirect to '/trucks'
  end