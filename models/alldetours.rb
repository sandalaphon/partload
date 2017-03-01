require_relative('../db/sql_runner.rb')
require_relative( '../models/partload.rb' )
require_relative( '../models/detour.rb' )
require_relative( '../models/truck.rb' )
require_relative( '../models/allroute.rb' )


class AllDetour
  attr_reader :id, :partload_id, :truck_id, :detour_distance, :detour_type
  def initialize (options)
    @id = options['id'].to_i if options['id']
    @partload_id = options['partload_id']
    @truck_id = options['truck_id']
    @detour_distance = options['detour_distance']
    @detour_type = options['detour_type']
  end

  def save()
    sql = "INSERT INTO alldetours (
    partload_id, truck_id, detour_distance, detour_type
    ) VALUES(
    #{@partload_id}, #{@truck_id}, #{@detour_distance}, '#{@detour_type}'
    )
    RETURNING * ;"
    result = SqlRunner.run(sql)
    @id = result.first['id'].to_i
  end

  def delete
    sql = "DELETE FROM alldetours WHERE id=#{@id}"
    SqlRunner.run(sql)
  end

  def self.delete_all
    sql = "DELETE FROM alldetours"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM alldetours"
    hashes= SqlRunner.run(sql)
    hashes.map{|hash| Detour.new(hash)}
  end



  def truck()
      sql = "SELECT * FROM trucks WHERE id = #{@truck_id}"
      hash = SqlRunner.run(sql).first
      return Truck.new(hash)
    end

    def partload()
      sql = "SELECT * FROM partloads WHERE id = #{@partload_id}"
      hash = SqlRunner.run(sql)[0]
      return User.new(hash)
    end

    def create_parent
      ploads = PartLoad.all
      trucks = Trucks.all
      @trucks_ids = trucks.map{|truck| truck.id}
     
      parent= []
      for pload in ploads
        truck=trucks.shuffle.pop
        sql= "SELECT detour_distance, detour_type FROM alldetours WHERE partload_id=#{pload.id} AND truck_id= #{truck.id}"
        hash=SqlRunner.run(sql)
        parent+=[pload_id, truck.id,hash.first['detour_distance'].to_i, hash.first['detour_type'] ]
      end
      return parent
    end

    #a adam and eve look like this [[pload_id, truck.id, detour_distance, detour_type ], [...], [...],  ... ]

    def populate
      seed_pop=[
          create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent, create_parent 
      ]
    end

     def sum_distances(parent_child)
      sum=0
      parent_child.keys.each{|array| sum+=array[2]}
      return sum
     end
  
    def select_best(pop_array)
      #check
      dist_hashes = pop_array.map{|pc| {pc=> sum_distances(pc)}}
      dist_hashes.sort!{|x,y|x.values[0] <=> y.values[0]}
      survivor_hashes=dist_hashes.first(10)
       survivors =survivor_hashes.map{|hash| hash.keys}
       return survivors
    end

   # look like this [[pload_id, truck.id, detour_distance, detour_type ], [...], [...],  ... ]
    

    def check_compatibility(parent1, parent2)
      par=parent1
      subs1 =par.pop
      !is_truck_in(parent2, subs1) ? direct_substitution(par, parent2, subs1) : is_in_same_place(parent2,subs1) ? chance_mutate(parent1, parent2) : sex_breed(par, parent2, subs1)
    end
    #REMEMBER PARENT1 HAS POPPED
    @popped_stuff = []

    def find_a_spare_truck(parent)
      truckids=[]
      parent.each{|x| truckids+=x[1]}
      spare_trucks = @trucks_ids
     truckids.each{|x| spare_trucks-[x]}
     return spare_trucks.pop
    end

    def find(pload_id, t_id)
      sql= "SELECT * FROM all detours WHERE partload_id=#{pload_id} AND truck_id=#{t_id}"
      hash=SqlRunner.run(sql)
      AllDetour.new(hash)
    end

    def chance_mutate(parent)
      chance=rand(100)
      return parent if chance<90
      new_truck_id = find_a_spare_truck(parent)
      par=parent
      popped = par.pop
      ploadid =popped[0]
      alldetour = find(ploadid, new_truck_id)
      new_pt = [alldetour.partload_id, alldetour.truck_id, alldetour.detour_distance, alldetour.detour_type] 
      new_life= par+=new_pt
      return new_life
    end

    def direct_substitution(popped_parent1, parent2, subs1)
      par2=parent2
      @popped_stuff+=par2.pop
      new_life =par2+=subs1
      return new_life
    end




#PARENT1 HAS POPPED
    def sex_breed(popped_parent1, parent2, subs1)
     position, displaced_truck, new_subs = find_position_and_truck(parent2, subs1)
     par=parent2
     truckid=subs1[1]
     par.delete_at(position) 
    pos_truck = findposition_by_truck(par, displaced_truck)
    ploadid =par[pos_truck][0]
    alldetour =find(ploadid, truckid)
    new_sub_piece=[alldetour.partload_id, alldetour.truck_id, alldetour.detour_distance, alldetour.detour_type]
    par.delete_at(pos_truck)
    par += subs1
    par += new_sub_piece
    new_life=par
    return new_life
    end

    def find_position_and_truck(parent,subs1)
       position=0
      parent.each_with_index{|unit, i| position=i if unit[0]==subs1[0]}
      new_subs =parent[position]
      displaced_truck=new_subs[1]
      return [position, displaced_truck, new_subs]
    end

    def findposition_by_truck(displaced_truck)
      position=0
      parent.each_with_index{|x,i| position=i if x[0]==displaced_truck}
      return position
    end
   

    def is_truck_in(parent2, subs1)
      parent2.any?{|array| array[1]==subs1[1]}
    end
    

end