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

end