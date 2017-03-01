require_relative('../db/sql_runner.rb')

class optimise

def initialize(partload_id, truck_id, detour, journey_type)
@partload_id= partload_id
@truck_id = truck_id
@detour= detour
@journey_type=journey_type
end

def create_parent
ploads=Partload.all

end












end