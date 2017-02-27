require_relative('../db/sql_runner.rb')


class PartLoad
  attr_reader :id
  attr_accessor  :name, :pvolume, :pcollect_x, :pcollect_y, :pdeliver_x, :pdeliver_y, :allocated, :flex
  def initialize (options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @pvolume = options['pvolume'].to_i
    @pcollect_x = options['pcollect_x'].to_i
    @pcollect_y = options['pcollect_y'].to_i
    @pdeliver_x = options['pdeliver_x'].to_i
    @pdeliver_y = options['pdeliver_y'].to_i
    @allocated = options['allocated']
    @flex = options['flex']

  end

  def save()
    sql = "INSERT INTO partloads (name, pvolume, pcollect_x, pcollect_y, pdeliver_x, pdeliver_y, allocated, flex
    ) VALUES (
    '#{@name}', '#{@pvolume}', '#{@pcollect_x}', '#{@pcollect_y}', '#{@pdeliver_x}', '#{@pdeliver_y}', '#{@allocated}', '#{@flex}') RETURNING *;"
    @id = SqlRunner.run(sql).first['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM partloads"
    result = SqlRunner.run(sql)
    return result.map{|hash| PartLoad.new(hash)}
  end

  def self.find( id )
    sql = "SELECT * FROM partloads WHERE id=#{id}"
    results = SqlRunner.run( sql )
    return PartLoad.new( results.first )
  end

  def self.delete_all
    sql = "DELETE FROM partloads"
    SqlRunner.run( sql )
  end

  def truck
    sql = "SELECT  * FROM trucks  
      INNER JOIN detours  ON detours.truck_id = trucks.id WHERE detours.partload_id = #{@id}
    "
    hashs = SqlRunner.run(sql)
    Truck.new(hashs.first)
  end

  def update
    sql = "UPDATE partloads SET (name, pvolume, pcollect_x, pcollect_y, pdeliver_x, pdeliver_y, allocated, flex
    ) = (
    '#{@name}', '#{@pvolume}', '#{@pcollect_x}', '#{@pcollect_y}', '#{@pdeliver_x}', '#{@pdeliver_y}', '#{@allocated}', '#{@flex}') WHERE id=#{@id}
    "
    SqlRunner.run(sql)
  end

  def minimise_distance()
  #For each truck we need distance from collection delivery and depot to partload collection and delivery 6 distances and the distance between partload collection and delivery: makes 7
  #depot=A, collect=B, deliver=c, partload-collect=d and partload deliver=e
  #distances array = [ad, bd, cd, ae, be, ce]
  trucks_that_can =Truck.all.select{|truck| ((truck.capacity - truck.anchor_volume) > @pvolume) && truck.has_part_load=="f"}
  return 0 if trucks_that_can==[]
  anchor_dists= trucks_that_can.map{|truck| truck.anchor_distance}

  #distances is an array of arrays of each trucks possible distances
  distances = trucks_that_can.map{|truck| all_dist_array(truck.depot_x, truck.depot_y, truck.collect_x, truck.collect_y, truck.deliver_x, truck.deliver_y, @pcollect_x, @pcollect_y, @pdeliver_x, @pdeliver_y)}

   #best for each is an array of hashes of index and min route distances for trucks that can. [{index => min distance}, {3 => 54}, etc] see best route for what each index is 0 = j1, 1=j2 etc
   best_for_each=distances.map {|tdistances| best_route(tdistances) }
   detour_min_hashs=[]
   best_for_each.each_with_index{|hash, index| detour_min_hashs << {hash.keys[0]=>hash.values[0] - anchor_dists[index]}}
   
   

   
   #the first hash in sorted is our huckleberry
   sorted = detour_min_hashs.sort_by{|i| i.values}
   


   route = sorted.first.keys[0]


   case route
   when 0
    detour_type= 'A PC PD B C A'
  when 1
    detour_type= 'A PC B PD C A'
  when 2
    detour_type= 'A PC B C PD A'
  when 3
    detour_type= 'A B PC PD C A'
  when 4
    detour_type= 'A B PC C PD A'
  when 5
    detour_type= 'A B C PC PD A'
  end
     #the following is to find the index of our truck in trucks that can
     truck_index=0
     detour_min_hashs.each_with_index{|i,j| truck_index=j if i==sorted[0]}
     our_truck=trucks_that_can[truck_index]


     detour_distance = sorted.first.first[1]
     truck_id = our_truck.id

     return [truck_id, detour_distance, detour_type]
     
   end

   def dist_between_points(x1,y1,x2,y2)
     p Math.sqrt((x1-x2)**2+(y1-y2)**2)
     return Math.sqrt((x1-x2)**2+(y1-y2)**2)
   end


  #all_dist_array 
  def all_dist_array(ax, ay, bx, by, cx, cy, pcx, pcy, pdx, pdy)
    d1=dist_between_points(ax,ay,pcx, pcy)
    d2=dist_between_points(bx,by,pcx, pcy)
    d3=dist_between_points(cx,cy,pcx, pcy)
    d4=dist_between_points(ax,ay,pdx, pdy)
    d5=dist_between_points(bx,by,pdx, pdy)
    d6=dist_between_points(cx,cy,pdx, pdy)
    d7=dist_between_points(ax,ay,bx, by)
    d8=dist_between_points(bx, by, cx, cy)
    d9=dist_between_points(cx,cy,ax, ay)
    d10=dist_between_points(pcx,pcy, pdx, pdy)


    p [d1, d2, d3, d4, d5, d6, d7, d8, d9, d10]
    return [d1, d2, d3, d4, d5, d6, d7, d8, d9, d10]
  end

  def anchor_distance (ax, ay, bx, by, cx, cy)
   return dist_between_points(ax, ay, bx, by)+dist_between_points(bx,by,cx,cy)+dist_between_points(cx, cy, ax, ay)
 end

 def best_route(distances)
  d1, d2, d3, d4, d5, d6, d7, d8, d9, d10 = distances
      #all possible collection and delivery routes
      j1= d1+d10+d5+d8+d9
      #j1 is A PC PD B C A
      j2= d1+d2+d5+d6+d9
      #j2 is A PC B PD C A
      j3= d1+d2+d8+d6+d4
      #j3 is A PC B C PD A
      j4= d7+d2+d10+d6+d9
      #j4 is A B PC PD C A
      j5= d7+d2+d3+d6+d4
      #j5 is A B PC C PD A
      j6= d7+d8+d3+d10+d4
      #j6 is A B C PC PD A

      journeys=[j1, j2, j3, j4, j5, j6]
      minimum = journeys.min
      p journeys
      opt_route_n_dist=Hash.new {}
      journeys.each_with_index{|j,i| opt_route_n_dist[i]=j if j==minimum}
      return opt_route_n_dist
    end
  end

  # anchor_distance(our_truck.depot_x, our_truck.depot_y, our_truck.collect_x, our_truck.collect_y, our_truck.deliver_x, our_truck.deliver_y)