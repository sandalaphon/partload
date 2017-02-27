require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/partload.rb' )
require_relative( '../models/detour.rb' )
require_relative( '../models/truck.rb' )

get '/partloads' do
  @partloads = PartLoad.all()
  erb ( :"partloads/index" )
end

get '/partloads/new' do
  @partlaods=PartLoad.all
  erb (:"partloads/new")
end

post '/partloads' do
 @partload = PartLoad.new(params)
 @partload.save
 redirect '/partloads'
end


post '/partloads/0/allocate' do
  erb(:"partloads/allocated")
  end

post '/partloads/0/unallocate' do
  erb(:"partloads/unallocate")
end

post '/partloads/:id/unallocate' do
  pload = PartLoad.find(params[:id])
  our_detour= pload.detour
  pload.allocated =false
  pload.update
  our_truck = pload.truck
  our_truck.has_part_load =false
  our_truck.update
  our_detour.delete
  
  redirect to '/partloads'
  end

post '/partloads/:id/allocate' do
  pload = PartLoad.find(params[:id])
  info =pload.minimise_distance
  redirect to '/partloads/notrucks' if info==0
  options={
    'partload_id'=>params[:id], 
    'truck_id'=>info[0], 
    'detour_distance'=>info[1], 
    'detour_type'=>info[2]
  }
  dtour =Detour.new(options)
  pload.allocated=true
  pload.update
  dtour.save
  our_truck = pload.truck
  our_truck.has_part_load =true
  our_truck.update
  
  redirect to '/detours'
end

get '/partloads/notrucks' do
  erb(:"/partloads/notrucks")
end

