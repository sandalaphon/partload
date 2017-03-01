require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/partload.rb' )
require_relative( '../models/detour.rb' )
require_relative( '../models/truck.rb' )
require_relative( '../models/allroute.rb' )
require_relative('../models/alldetours.rb')





  get '/alldetours' do 
    ploads=PartLoad.all
    ploads.each{|pload| alldetours_options_hash(pload)}
  erb(:"/alldetours/index")
  end

  get '/alldetours/optimise' do
  @result =AllDetour.find_optimal
  erb(:"/alldetours/optimise")
    end

  def alldetours_options_hash(pload)
    trucks_distances = pload.minimise_distance[3] 
    trucks_distances.each{ |hash| 
    adtour=AllDetour.new({
      'partload_id'=> pload.id,
      'truck_id' => hash.values[1],
      'detour_distance' => hash.values[0],
      'detour_type' => hash.keys[0]
      })
    adtour.save
    }
  end
