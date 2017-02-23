require_relative('../db/sql_runner.rb')

class Truck

attr_accessor :type, :depot_x, :depot_y, :capacity, :anchor_volume, :collection_date, :delivery_date, :collect_x, :collect_y, :deliver_x, :deliver_y

attr_reader :id

def initialize (options)
@id = options['id'].to_i if options['id']
@type = options['type']
@depot_x = options['depot_x'].to_i
@depot_y = options['depot_y'].to_i
@capacity = options['capacity'].to_i
@anchor_volume = options['anchor_volume'].to_i
@collection_date = options['collection_date']
@delivery_date = options['delivery_date']
@collect_y = options['collect_y'].to_i
@collect_x = options['collect_x'].to_i
@deliver_x = options['deliver_x'].to_i
@deliver_y = options['deliver_y'].to_i
end

def save()
  sql = "INSERT INTO trucks (
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
            deliver_y
  ) VALUES (
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
            '#{deliver_y}'
            )
  RETURNING *;"
  @id = SqlRunner.run(sql).first['id'].to_i
  end


end