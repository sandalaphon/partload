require_relative('../models/truck.rb')
require_relative('../models/partload.rb')
require_relative('../models/detour.rb')
require_relative('../models/allroute.rb')
require_relative('../models/alldetours.rb')
require('pry')
require('pry-byebug')

AllDetour.delete_all
Detour.delete_all
Truck.delete_all
PartLoad.delete_all
AllRoute.delete_all


truck1 = Truck.new({
  'name' => 'DX04',
  'type' => '18t',
  'depot_x' => rand(1000),
  'depot_y' => rand(1000),
  'capacity' => 2000,
  'anchor_volume' => 1100,
  'collection_date' => '2017-03-21 09:00:00',
  'delivery_date' => '2017-03-21 16:00:00',
  'collect_x' => rand(1000),
  'collect_y' => rand(1000),
  'deliver_x' => rand(1000),
  'deliver_y' => rand(1000),
  'has_part_load' => false
})
truck1.save

truck2 = Truck.new({
  'name' => 'JN32',
  'type' => '18t',
  'depot_x' => rand(1000),
  'depot_y' => rand(1000),
  'capacity' => 2000,
  'anchor_volume' => 1400,
  'collection_date' => '2017-06-21 09:00:00',
  'delivery_date' => '2017-06-21 16:00:00',
  'collect_x' => rand(1000),
  'collect_y' => rand(1000),
  'deliver_x' => rand(1000),
  'deliver_y' => rand(1000),
  'has_part_load' => false
})
truck2.save

truck3 = Truck.new({
  'name' => 'JX55',
  'type' => '18t',
  'depot_x' => rand(1000),
  'depot_y' => rand(1000),
  'capacity' => 2000,
  'anchor_volume' => 1400,
  'collection_date' => '2017-06-21 09:00:00',
  'delivery_date' => '2017-06-21 16:00:00',
  'collect_x' => rand(1000),
  'collect_y' => rand(1000),
  'deliver_x' => rand(1000),
  'deliver_y' => rand(1000),
  'has_part_load' => false
})
truck3.save

truck4 = Truck.new({
  'name' => 'JX55',
  'type' => '18t',
  'depot_x' => rand(1000),
  'depot_y' => rand(1000),
  'capacity' => 2000,
  'anchor_volume' => rand(1000..1500),
  'collection_date' => '2017-06-21 09:00:00',
  'delivery_date' => '2017-06-21 16:00:00',
  'collect_x' => rand(1000),
  'collect_y' => rand(1000),
  'deliver_x' => rand(1000),
  'deliver_y' => rand(1000),
  'has_part_load' => false
})
truck4.save
truck5 = Truck.new({
  'name' => 'JX55',
  'type' => '18t',
  'depot_x' => rand(1000),
  'depot_y' => rand(1000),
  'capacity' => 2000,
  'anchor_volume' => rand(1000..1500),
  'collection_date' => '2017-06-21 09:00:00',
  'delivery_date' => '2017-06-21 16:00:00',
  'collect_x' => rand(1000),
  'collect_y' => rand(1000),
  'deliver_x' => rand(1000),
  'deliver_y' => rand(1000),
  'has_part_load' => false
})
truck5.save
truck6 = Truck.new({
  'name' => 'JX55',
  'type' => '18t',
  'depot_x' => rand(1000),
  'depot_y' => rand(1000),
  'capacity' => 2000,
  'anchor_volume' => rand(1000..1500),
  'collection_date' => '2017-06-21 09:00:00',
  'delivery_date' => '2017-06-21 16:00:00',
  'collect_x' => rand(1000),
  'collect_y' => rand(1000),
  'deliver_x' => rand(1000),
  'deliver_y' => rand(1000),
  'has_part_load' => false
})
truck6.save
truck7 = Truck.new({
  'name' => 'JX55',
  'type' => '18t',
  'depot_x' => rand(1000),
  'depot_y' => rand(1000),
  'capacity' => 2000,
  'anchor_volume' => rand(1000..1500),
  'collection_date' => '2017-06-21 09:00:00',
  'delivery_date' => '2017-06-21 16:00:00',
  'collect_x' => rand(1000),
  'collect_y' => rand(1000),
  'deliver_x' => rand(1000),
  'deliver_y' => rand(1000),
  'has_part_load' => false
})
truck7.save
truck8 = Truck.new({
  'name' => 'JX55',
  'type' => '18t',
  'depot_x' => rand(1000),
  'depot_y' => rand(1000),
  'capacity' => 2000,
  'anchor_volume' => rand(1000..1500),
  'collection_date' => '2017-06-21 09:00:00',
  'delivery_date' => '2017-06-21 16:00:00',
  'collect_x' => rand(1000),
  'collect_y' => rand(1000),
  'deliver_x' => rand(1000),
  'deliver_y' => rand(1000),
  'has_part_load' => false
})
truck8.save
truck9 = Truck.new({
  'name' => 'JX55',
  'type' => '18t',
  'depot_x' => rand(1000),
  'depot_y' => rand(1000),
  'capacity' => 2000,
  'anchor_volume' => rand(1000..1500),
  'collection_date' => '2017-06-21 09:00:00',
  'delivery_date' => '2017-06-21 16:00:00',
  'collect_x' => rand(1000),
  'collect_y' => rand(1000),
  'deliver_x' => rand(1000),
  'deliver_y' => rand(1000),
  'has_part_load' => false
})
truck9.save
truck10 = Truck.new({
  'name' => 'JX55',
  'type' => '18t',
  'depot_x' => rand(1000),
  'depot_y' => rand(1000),
  'capacity' => 2000,
  'anchor_volume' => rand(1000..1500),
  'collection_date' => '2017-06-21 09:00:00',
  'delivery_date' => '2017-06-21 16:00:00',
  'collect_x' => rand(1000),
  'collect_y' => rand(1000),
  'deliver_x' => rand(1000),
  'deliver_y' => rand(1000),
  'has_part_load' => false
})
truck10.save
truck11 = Truck.new({
  'name' => 'JX55',
  'type' => '18t',
  'depot_x' => rand(1000),
  'depot_y' => rand(1000),
  'capacity' => 2000,
  'anchor_volume' => rand(1000..1500),
  'collection_date' => '2017-06-21 09:00:00',
  'delivery_date' => '2017-06-21 16:00:00',
  'collect_x' => rand(1000),
  'collect_y' => rand(1000),
  'deliver_x' => rand(1000),
  'deliver_y' => rand(1000),
  'has_part_load' => false
})
truck11.save
truck12 = Truck.new({
  'name' => 'JX55',
  'type' => '18t',
  'depot_x' => rand(1000),
  'depot_y' => rand(1000),
  'capacity' => 2000,
  'anchor_volume' => rand(1000..1500),
  'collection_date' => '2017-06-21 09:00:00',
  'delivery_date' => '2017-06-21 16:00:00',
  'collect_x' => rand(1000),
  'collect_y' => rand(1000),
  'deliver_x' => rand(1000),
  'deliver_y' => rand(1000),
  'has_part_load' => false
})
truck12.save
truck13 = Truck.new({
  'name' => 'JX55',
  'type' => '18t',
  'depot_x' => rand(1000),
  'depot_y' => rand(1000),
  'capacity' => 2000,
  'anchor_volume' => rand(1000..1500),
  'collection_date' => '2017-06-21 09:00:00',
  'delivery_date' => '2017-06-21 16:00:00',
  'collect_x' => rand(1000),
  'collect_y' => rand(1000),
  'deliver_x' => rand(1000),
  'deliver_y' => rand(1000),
  'has_part_load' => false
})
truck13.save
truck14 = Truck.new({
  'name' => 'JX55',
  'type' => '18t',
  'depot_x' => rand(1000),
  'depot_y' => rand(1000),
  'capacity' => 2000,
  'anchor_volume' => rand(1000..1500),
  'collection_date' => '2017-06-21 09:00:00',
  'delivery_date' => '2017-06-21 16:00:00',
  'collect_x' => rand(1000),
  'collect_y' => rand(1000),
  'deliver_x' => rand(1000),
  'deliver_y' => rand(1000),
  'has_part_load' => false
})
truck14.save
truck15 = Truck.new({
  'name' => 'JX55',
  'type' => '18t',
  'depot_x' => rand(1000),
  'depot_y' => rand(1000),
  'capacity' => 2000,
  'anchor_volume' => rand(1000..1500),
  'collection_date' => '2017-06-21 09:00:00',
  'delivery_date' => '2017-06-21 16:00:00',
  'collect_x' => rand(1000),
  'collect_y' => rand(1000),
  'deliver_x' => rand(1000),
  'deliver_y' => rand(1000),
  'has_part_load' => false
})
truck15.save
truck16 = Truck.new({
  'name' => 'JX55',
  'type' => '18t',
  'depot_x' => rand(1000),
  'depot_y' => rand(1000),
  'capacity' => 2000,
  'anchor_volume' => rand(1000..1500),
  'collection_date' => '2017-06-21 09:00:00',
  'delivery_date' => '2017-06-21 16:00:00',
  'collect_x' => rand(1000),
  'collect_y' => rand(1000),
  'deliver_x' => rand(1000),
  'deliver_y' => rand(1000),
  'has_part_load' => false
})
truck16.save
truck17 = Truck.new({
  'name' => 'JX55',
  'type' => '18t',
  'depot_x' => rand(1000),
  'depot_y' => rand(1000),
  'capacity' => 2000,
  'anchor_volume' => rand(1000..1500),
  'collection_date' => '2017-06-21 09:00:00',
  'delivery_date' => '2017-06-21 16:00:00',
  'collect_x' => rand(1000),
  'collect_y' => rand(1000),
  'deliver_x' => rand(1000),
  'deliver_y' => rand(1000),
  'has_part_load' => false
})
truck17.save


partload1 = PartLoad.new({
  'name' => 'Dorothy Perkins',
  'pvolume' => 200,
   'pcollect_x' => rand(1000),
    'pcollect_y' => rand(1000),
     'pdeliver_x' => rand(1000),
      'pdeliver_y' => rand(1000),
       'allocated' => FALSE,
        'flex' => true
  })
partload1.save

partload2 = PartLoad.new({
  'name' => 'Debbie Harry',
  'pvolume' => rand(100..500),
   'pcollect_x' => rand(1000),
    'pcollect_y' => rand(1000),
     'pdeliver_x' => rand(1000),
      'pdeliver_y' => rand(1000),
       'allocated' => FALSE,
        'flex' => true
  })
partload2.save
partload3 = PartLoad.new({
  'name' => 'Debbie Harry',
  'pvolume' => rand(100..500),
   'pcollect_x' => rand(1000),
    'pcollect_y' => rand(1000),
     'pdeliver_x' => rand(1000),
      'pdeliver_y' => rand(1000),
       'allocated' => FALSE,
        'flex' => true
  })
partload3.save
partload4 = PartLoad.new({
  'name' => 'Debbie Harry',
  'pvolume' => rand(100..500),
   'pcollect_x' => rand(1000),
    'pcollect_y' => rand(1000),
     'pdeliver_x' => rand(1000),
      'pdeliver_y' => rand(1000),
       'allocated' => FALSE,
        'flex' => true
  })
partload4.save
partload5 = PartLoad.new({
  'name' => 'Debbie Harry',
  'pvolume' => rand(100..500),
   'pcollect_x' => rand(1000),
    'pcollect_y' => rand(1000),
     'pdeliver_x' => rand(1000),
      'pdeliver_y' => rand(1000),
       'allocated' => FALSE,
        'flex' => true
  })
partload5.save
partload6 = PartLoad.new({
  'name' => 'Debbie Harry',
  'pvolume' => rand(100..500),
   'pcollect_x' => rand(1000),
    'pcollect_y' => rand(1000),
     'pdeliver_x' => rand(1000),
      'pdeliver_y' => rand(1000),
       'allocated' => FALSE,
        'flex' => true
  })
partload6.save
partload7 = PartLoad.new({
  'name' => 'Debbie Harry',
  'pvolume' => rand(100..500),
   'pcollect_x' => rand(1000),
    'pcollect_y' => rand(1000),
     'pdeliver_x' => rand(1000),
      'pdeliver_y' => rand(1000),
       'allocated' => FALSE,
        'flex' => true
  })
partload7.save
partload8 = PartLoad.new({
  'name' => 'Debbie Harry',
  'pvolume' => rand(100..500),
   'pcollect_x' => rand(1000),
    'pcollect_y' => rand(1000),
     'pdeliver_x' => rand(1000),
      'pdeliver_y' => rand(1000),
       'allocated' => FALSE,
        'flex' => true
  })
partload8.save
partload9 = PartLoad.new({
  'name' => 'Debbie Harry',
  'pvolume' => rand(100..500),
   'pcollect_x' => rand(1000),
    'pcollect_y' => rand(1000),
     'pdeliver_x' => rand(1000),
      'pdeliver_y' => rand(1000),
       'allocated' => FALSE,
        'flex' => true
  })
partload9.save
partload10 = PartLoad.new({
  'name' => 'Debbie Harry',
  'pvolume' => rand(100..500),
   'pcollect_x' => rand(1000),
    'pcollect_y' => rand(1000),
     'pdeliver_x' => rand(1000),
      'pdeliver_y' => rand(1000),
       'allocated' => FALSE,
        'flex' => true
  })
partload10.save


binding.pry
nil