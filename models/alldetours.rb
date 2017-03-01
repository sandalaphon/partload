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
      dist_hashes = pop_array.map{|pc| {pc=> sum_distances(pc)}}
      dist_hashes.sort!{|x,y|x.values[0] <=> y.values[0]}
      survivors=dist_hashes.first(10)
      return survivors
    end

    #ALL SUBSEQUENT GENERATIONS LOOK LIKE THIS:
    # [{[[pload_id, truck.id, detour_distance, detour_type ], [...], [...],  ... ] => TOTAL DISTANCE}, {[[pload_id, truck.id, detour_distance, detour_type ], [...], [...],  ... ] => TOTAL DISTANCE}, ....]
    #THINK OF IT LIKE THIS [{parent=>dist}, {parent=>dist}, ...]

    def check_compatibility(parent1, parent2)
      parent1.shuffle!
      subs1 =parent1.pop
      !is_truck_in(parent2, subs1) ? direct_substitution(parent2,subs1) : is_in_same_place(parent2,subs1) ? chance_mutate(parent1, parent2) : sex_breed(parent1, parent2, subs1)
    end
    #REMEMBER PARENT1 HAS POPPED
    @popped_stuff=[]

    def find_a_spare_truck(parent)
      w=[]
      parent.each{|x| w+=x.keys}
      trucks_in_p =w.map{|y| y[1]}
      spare_trucks = @trucks_ids
     trucks_in_p.each{|x| spare_trucks-[x]}
     return trucks_in_p.pop
    end

    def find(pload_id, t_id)
      sql= "SELECT * FROM all detours WHERE partload_id=#{pload_id} AND truck_id=#{t_id}"
      hash=SqlRunner.run(sql)
      AllDetour.new(hash)
    end

    def chance_mutate(parent)
      new_truck_id = find_a_spare_truck(parent)
      par=parent
      popped = par.pop
      ploadid =popped.keys.first[0]
      alldetour = find(ploadid, new_truck_id)
      new_pt={[alldetour.partload_id, alldetour.truck_id, alldetour.detour_distance, alldetour.detour_type]}
      new_life= par+=new_pt
      return new_life
    end

    def direct_substitution(parent1, parent2, subs1)
    end



    def sex_breed(parent1, parent2)
      parent1.shuffle!
      parent2.shuffle!
      subs1 =parent1.pop
      is_truck_in(parent2, subs1) ? remove_n_replace(parent2, subs1) : mutate(parent2)
    end

    def remove_n_replace(parent2,subs1)
     ind=0
      parent2.each_with_index{|hash, i| ind= i if hash.keys==subs1.keys}
      missing1=parent2.keys.delete_if{|hash| hash[1]==subs1[1]}
      sql= "SELECT * FROM alldetours where partload"
    end

    def is_truck_in(parent2, subs1)
      parent2.keys.any?{|hash| hash[1]==subs1[1]}
    end
    

end