require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/trucks_controller')
require_relative('controllers/partloads_controller')
require_relative('controllers/detours_controller')

get '/' do
  erb( :index )
end