require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/partload.rb' )
require_relative( '../models/detour.rb' )
require_relative( '../models/detour.rb' )

get "/detours" do
  @detours=Detour.all
erb (:"detours/index")
end

