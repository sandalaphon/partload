require_relative('../models/truck.rb')
require_relative('../models/partload.rb')
require_relative('../models/detour.rb')
require('pry')
require('pry-byebug')

Detour.delete_all
Truck.delete_all
PartLoad.delete_all

truck1 = Truck.new({
  'name' => 'DX04',
  'type' => '18t',
  'depot_x' => 4424,
  'depot_y' => 333,
  'capacity' => 2000,
  'anchor_volume' => 1100,
  'collection_date' => '2017-03-21 09:00:00',
  'delivery_date' => '2017-03-21 16:00:00',
  'collect_x' => 8737,
  'collect_y' => 456,
  'deliver_x' => 4323,
  'deliver_y' => 9827,
  'has_part_load' => false
})
truck1.save

truck2 = Truck.new({
  'name' => 'JN32',
  'type' => '18t',
  'depot_x' => 442,
  'depot_y' => 33,
  'capacity' => 2000,
  'anchor_volume' => 1400,
  'collection_date' => '2017-06-21 09:00:00',
  'delivery_date' => '2017-06-21 16:00:00',
  'collect_x' => 873,
  'collect_y' => 456,
  'deliver_x' => 4323,
  'deliver_y' => 827,
  'has_part_load' => false
})
truck2.save

truck3 = Truck.new({
  'name' => 'JX55',
  'type' => '18t',
  'depot_x' => 1000,
  'depot_y' => 1000,
  'capacity' => 2000,
  'anchor_volume' => 1400,
  'collection_date' => '2017-06-21 09:00:00',
  'delivery_date' => '2017-06-21 16:00:00',
  'collect_x' => 340,
  'collect_y' => 4240,
  'deliver_x' => 430,
  'deliver_y' => 5000,
  'has_part_load' => false
})
truck3.save


partload1 = PartLoad.new({
  'name' => 'Dorothy Perkins',
  'pvolume' => 200,
   'pcollect_x' => 342,
    'pcollect_y' => 4244,
     'pdeliver_x' => 432,
      'pdeliver_y' => 5432,
       'allocated' => FALSE,
        'flex' => FALSE
  })
partload1.save

partload2 = PartLoad.new({
  'name' => 'Debbie Harry',
  'pvolume' => 200,
   'pcollect_x' => 3420,
    'pcollect_y' => 244,
     'pdeliver_x' => 432,
      'pdeliver_y' => 5432,
       'allocated' => FALSE,
        'flex' => FALSE
  })
partload2.save

# detour1 = Detour.new({
# 'partload_id'=>partload1.id,
# 'truck_id' =>truck1.id,
# 'detour_distance' => 300,
# 'detour_type' => 'j1',
#   })
# detour1.save

binding.pry
nil