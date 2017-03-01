require_relative('../db/sql_runner.rb')

class Truck

  attr_accessor :name, :type, :depot_x, :depot_y, :capacity, :anchor_volume, :collection_date, :delivery_date, :collect_x, :collect_y, :deliver_x, :deliver_y, :has_part_load

  attr_reader :id, :anchor_distance

  def initialize (options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @type = options['type']
    @depot_x = options['depot_x'].to_i
    @depot_y = options['depot_y'].to_i
    @capacity = options['capacity'].to_i
    @anchor_volume = options['anchor_volume'].to_i
    @collection_date = options['collection_date']
    @delivery_date = options['delivery_date']
    @collect_x = options['collect_y'].to_i
    @collect_y = options['collect_x'].to_i
    @deliver_x = options['deliver_x'].to_i
    @deliver_y = options['deliver_y'].to_i
    @has_part_load = options['has_part_load']
# @anchor_distance = anchor_distance(@depot_x, @depot_y, @collect_x, @collect_y, @deliver_x, @deliver_y)
end

def save()
  sql = "INSERT INTO trucks (
  name,
  type,
  depot_x,
  depot_y,
  capacity,
  anchor_volume,
  collection_date,
  delivery_date,
  collect_x,
  collect_y,
  deliver_x,
  deliver_y,
  has_part_load
  ) VALUES (
  '#{@name}',
  '#{@type}',
  '#{@depot_x}',
  '#{@depot_y}',
  '#{@capacity}',
  '#{@anchor_volume}',
  '#{@collection_date}',
  '#{@delivery_date}',
  '#{@collect_x}',
  '#{@collect_y}',
  '#{@deliver_x}',
  '#{@deliver_y}',
  '#{@has_part_load}'
  )
  RETURNING *;"
  @id = SqlRunner.run(sql).first['id'].to_i
end

def self.all
  sql= "SELECT * FROM trucks"
  trucks= SqlRunner.run(sql).map{|hash| Truck.new(hash)}
  return trucks
end

def self.delete_all
  sql = "DELETE FROM trucks"
  SqlRunner.run(sql)
end

def update
  sql = "UPDATE trucks SET (
  
  name,
  type,
  depot_x,
  depot_y,
  capacity,
  anchor_volume,
  collection_date,
  delivery_date,
  collect_x,
  collect_y,
  deliver_x,
  deliver_y,
  has_part_load
  ) = (

  '#{@name}',
  '#{@type}',
  '#{@depot_x}',
  '#{@depot_y}',
  '#{@capacity}',
  '#{@anchor_volume}',
  '#{@collection_date}',
  '#{@delivery_date}',
  '#{@collect_x}',
  '#{@collect_y}',
  '#{@deliver_x}',
  '#{@deliver_y}',
  '#{@has_part_load}'
  ) WHERE id=#{@id}
  "
  SqlRunner.run(sql)
end

def anchor_distance 
 return dist_between_points(@depot_x, @depot_y, @collect_x, @collect_y)+dist_between_points(@collect_x,@collect_y,@deliver_x,@deliver_y)+dist_between_points(@deliver_x, @deliver_y, @depot_x, @depot_y)
end


def dist_between_points(x1,y1,x2,y2)
 p Math.sqrt((x1-x2)**2+(y1-y2)**2)
 return Math.sqrt((x1-x2)**2+(y1-y2)**2)
end

def partloads()
  sql = "SELECT partloads.* FROM partloads INNER JOIN alldetours ON alldetours.partload_id = partload.id WHERE alldetours.truck_id = #{@id}"
    hashes=SqlRunner.run(sql)
   return hashes.map {|hash| PartLoad.new(hash)}
end

end