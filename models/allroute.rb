require_relative('../db/sql_runner.rb')
require('json')

class AllRoute
  attr_reader :id, :partload_id, :json_array_hashes

  def initialize( options)
    @id= options['id'].to_i if options['id']
    @partload_id =options['partload_id']
    @json_array_hashes =options['json_array_hashes']
  end

  def save
    sql = "INSERT INTO allroutes 
    (partload_id, json_array_hashes) VALUES (#{@partload_id}, '#{@json_array_hashes}')
    RETURNING *"
    @id=SqlRunner.run(sql).first['id'].to_i
  end

  def self.delete_all
    sql = "DELETE FROM allroutes"
    SqlRunner.run(sql)
  end

  def self.make_json
    ploads = PartLoad.all
    
      # minimise_distance[3] gives [{number=>dist, 
      # truck:truck_id},.. ] where number is int represents 
      #journey_type 0=j1, 1=j2 etc
      pload_all_best = ploads.map{|pload| pload.minimise_distance[3]}
        #pload_all_best is an array of arrays each unit array being of the form: 
        # [{number=>dist, truck:truck_id}, {}, ...]
        #lets save this in out table for each pload.
        #for to_json we need a hash therefore convert like so:
        
        counter=0
        for pload in ploads 
          jsonhash={}
          jsonhash[:marker] = pload_all_best[counter]
          options={
            'partload_id'=>pload.id, 
            'json_array_hashes'=> jsonhash.to_json
          }
          allroute=AllRoute.new(options)
          allroute.save
          counter += 1
        end
      end

      def self.all
        sql= "SELECT * FROM allroutes"
        jsonroutes= SqlRunner.run(sql).map{|hash| AllRoute.new(hash)}
        return routes
      end

      def find(pload_id)
        sql = "SELECT * FROM allroutes WHERE partload_id=pload_id"
        hash=SqlRunner.run(sql)
        AllRoute.new(hash)
      end

      def populate
        child1= create_child
        child2= create_child
        child3= create_child
        child4= create_child
        child5= create_child
        child6= create_child
        child7= create_child
        child8= create_child
        child9= create_child
        child10= create_child
        child11= create_child
        child12= create_child
        child13= create_child
        child14= create_child
        child15= create_child
        child16= create_child
        child17= create_child
        child18= create_child
        child19= create_child
        child20= create_child
        child21= create_child
        child22= create_child
        child23= create_child
        child24= create_child
        child25= create_child
        child26= create_child
        child27= create_child
        child28= create_child
        child29= create_child
        child30= create_child
        child31= create_child
        child32= create_child
        child33= create_child
        child34= create_child
        child35= create_child
        child36= create_child
        child37= create_child
        child38= create_child
        child39= create_child
        child40= create_child
        child41= create_child
        child42= create_child
        child43= create_child
        child44= create_child
        child45= create_child
        child46= create_child
        child47= create_child
        child48= create_child
        child49= create_child
        child50= create_child
        child51= create_child
        child52= create_child
        child53= create_child
        child54= create_child
        child55= create_child
        child56= create_child
        child57= create_child
        child58= create_child
        child59= create_child
        child60= create_child
        child61= create_child
        child62= create_child
        child63= create_child
        child64= create_child
        child65= create_child
        @population=[child1,
          child2,child3,child4,child5,child6,child7,child8,child9,child10,child11,child12,child13,child14,child15,child16,child17,child18,child19,child20,child21,child22,child23,child24,child25,child26,child27,child28,child29,child30,child31,child32,child33,child34,child35,child36,child37,child38,child39,child40,child41,child42,child43,child44,child45,child46,child47,child48,child49,child50,child51,child52,child53,child54,child55,child56,child57,child58,child59,child60,child61,child62,child63,child64]
          return @population
        end



        def select_best
          h={}
          for child in @population
            h[child_distance(child)]=child
          end
         # h is {distance=>child, distance=>child,...}
          sorted =h.sort.to_h
          return sorted.first(10).to_h
        end

        def new_child(parent1,parent2)
         #parent is a child (no distance) 
         x = rand(parent1.length)
         pload_id=parent1.keys[x]
         hashes=parent1.values[x]
          if parent2.delete(pload_id)==nil
            nchild2 = parent2
          else

          end
        end

        def get_truck_from_child(pload_id)

        end

        def child_distance(child)
          x=[]
          child.each{|hash|x+=hash.values}
          #now[{number=>dist,truck:truck_id}, {number=>dist,truck:truck_id},...]
          p=x.map{|hash| hash.values[0]}
          p.reduce(:+)
        end

# child = [{pload_id=>{number=>dist,truck:truck_id}},...]
      def create_child
        child1=[]
        dummy=[]
        dhash={}
        ploads=PartLoad.all
        for pload in ploads
          aroute=pload.find(pload.id)
        # {marker:=>[{number=>dist, truck:truck_id}, {}, ...]}
        hashes=JSON.parse(aroute.json_array_hashes)
        hashes=hashes[:marker].shuffle
        dummy = hashes.pop
        dhash[pload.id.to_i]=dummy
        child1<<dhash
        return child1
      end

    end

  end








