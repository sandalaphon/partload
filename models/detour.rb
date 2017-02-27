require_relative('../db/sql_runner.rb')

class Detour
  attr_reader :id, :partload_id, :truck_id, :detour_distance, :detour_type, :detour_time
  def initialize (options)
    @id = options['id'].to_i if options['id']
    @partload_id = options['partload_id']
    @truck_id = options['truck_id']
    @detour_distance = options['detour_distance']
    @detour_type = options['detour_type']

  end

  def save()
    sql = "INSERT INTO detours (
    partload_id, truck_id, detour_distance, detour_type
    ) VALUES(
    #{@partload_id}, #{@truck_id}, #{@detour_distance}, '#{@detour_type}'
    )
    RETURNING * ;"
    result = SqlRunner.run(sql)
    @id = result.first['id'].to_i
  end

  def delete
    sql = "DELETE FROM detours WHERE id=#{@id}"
    SqlRunner.run(sql)
  end

  def self.delete_all
    sql = "DELETE FROM detours"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM detours"
    hashes= SqlRunner.run(sql)
    hashes.map{|hash| Detour.new(hash)}
  end





  


#   def minimise_distance(partload)
# #For each truck we need distance from collection delivery and depot to partload collection and delivery 6 distances and the distance between partload collection and delivery: makes 7
# #depot=A, collect=B, deliver=c, partload-collect=d and partload deliver=e
# #distances array = [ad, bd, cd, ae, be, ce]
# trucks_that_can=Truck.all.select{|truck| (truck.capacity - truck.anchor_volume > partload.pvolume) && partload.allocated==FALSE}

# #distances is an array of arrays of each trucks possible distances
# distances = trucks_that_can.map{|truck| all_dist_array(truck.depot_x, truck.depot_y, truck.collect_x, truck.collect_y, truck.deliver_x, truck.deliver_y, partload.pcollect_x, partload.pcollect_y, partload.pdeliver_x, partload.pdeliver_y)}

#  #best for each is an array of hashes of index and min route distances for trucks that can. [{index => min distance}, {3 => 54}, etc] see best route for what each index is 0 = j1, 1=j2 etc
#  best_for_each=distances.map {|tdistances| best_route(tdistances) }
#  #the first hash in sorted is our huckleberry
#  sorted = best_for_each.sort_by{|i| i.values}

#  route = sorted.first.first[0]
#     case route
#       when 0
#       @detour_type= 'j1'
#       when 1
#       @detour_type= 'j2'
#       when 2
#       @detour_type= 'j3'
#       when 3
#       @detour_type= 'j4'
#       when 4
#       @detour_type= 'j5'
#       when 5
#       @detour_type= 'j6'
#    end
#    #the following is to find the index of our truck in trucks that can
#    truck_index=0
#   best_for_each.each_with_index{|i,j| truck_index=j if i==sorted[0]}

#   @truck_id = trucks_that_can[truck_index].id
#   @detour_distance = sorted.first.first[1]
# end

# def dist_between_points(x1,y1,x2,y2)
#   return Math.sqrt((x1-x2)+(y1-y2))
# end


# #all_dist_array 
# def all_dist_array(Ax, Ay, Bx, By, Cx, Cy, PCx, PCy, PDx, PDy)
#   d1=dist_between_points(Ax,Ay,PCx, PCy)
#   d2=dist_between_points(Bx,By,PCx, PCy)
#   d3=dist_between_points(Cx,Cy,PCx, PCy)
#   d4=dist_between_points(Ax,Ay,PDx, PDy)
#   d5=dist_between_points(Bx,By,PDx, PDy)
#   d6=dist_between_points(Cx,Cy,PDx, PDy)
#   d7=dist_between_points(Ax,Ay,Bx, By)
#   d8=dist_between_points(Bx, By, Cx, Cy)
#   d9=dist_between_points(Cx,Cy,Ax, Ay)
#   d10=dist_between_points(PCx,PCy, PDx, PDy)


#   return [d1, d2, d3, d4, d5, d6, d7, d8, d9, d10]
# end

# def anchor_distance (Ax, Ay, Bx, By, Cx, Cy)
#  return dist_between_points(Ax, Ay, Bx, By)+dist_between_points(Bx,By,Cx,Cy)+dist_between_points(Cx, Cy, Ax, Ay)
# end

# def best_route(distances)
#   d1, d2, d3, d4, d5, d6, d7, d8, d9, d10 = distances
#     #all possible collection and delivery routes
#     j1= d1+d10+d5+d8+d9
#     #j1 is A PC PD B C A
#     j2= d1+d2+d5+d6+d9
#     #j2 is A PC B PD C A
#     j3= d1+d2+d8+d6+d4
#     #j3 is A PC B C PD A
#     j4= d7+d2+d10+d6+d9
#     #j4 is A B PC PD C A
#     j5= d7+d2+d3+d6+d4
#     #j5 is A B PC C PD A
#     j6= d7+d8+d3+d10+d4
#     #j6 is A B C PC PD A

#     journeys=[j1, j2, j3, j4, j5, j6]
#     minimum = journeys.min
#     opt_route_n_dist=Hash.new {}
#     journeys.each_with_index{|j,i| opt_route_n_dist[i]=j if j==minimum}
#     return opt_route_n_dist
#   end




end