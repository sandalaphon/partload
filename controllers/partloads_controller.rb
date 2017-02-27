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

 get 'partloads/0/allocate' do
  erb(:"partloads/allocated")
  end

post '/partloads/0/allocate' do
  erb(:"partloads/allocated")
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
  # pload.truck.has_part_load =true
  # pload.truck.name="this"
  # pload.truck.update
  
  redirect to '/detours'
end

get '/partloads/notrucks' do
  erb(:"/partloads/notrucks")
end

