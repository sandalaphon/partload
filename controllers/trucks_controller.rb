require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/truck.rb' )

get '/trucks' do
  @trucks = Truck.all()
  erb ( :"trucks/index" )
end