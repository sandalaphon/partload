require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/trucks_controller')
require_relative('controllers/partloads_controller')
require_relative('controllers/detours_controller')
require_relative('controllers/allroute_controller')
require_relative('controllers/alldetours_controller.rb')

get '/' do
  erb( :index )
end