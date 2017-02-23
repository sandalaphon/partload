require_relative('../models/truck.rb')

require('pry-byebug')

truck1 = Truck.new({
  'type' => '18t',
  'depot_x' => 4424,
  'depot_y' => 333,
  'capacity' => 2000,
  'anchor_volume' => 1100,
  'collection_date' => '2017-03-21 09:00:00',
  'delivery_date' => '2017-03-21 16:00:00',
  'collect_y' => 8737,
  'collect_x' => 456,
  'deliver_x' => 4323,
  'deliver_y' => 9827
})
truck1.save