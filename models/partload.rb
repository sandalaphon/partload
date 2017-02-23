require_relative('../db/sql_runner.rb')

class PartLoad

def initialize (options)
@id = options['id'].to_i if options['id']
@pvolume = options['pvolume'].to_i
@pcollect_x = options['pcollect_x']
@pcollect_y = options['pcollect_y']
@pdeliver_x = options['pdeliver_x']
@pdeliver_y = options['pdeliver_y']
@allocated = options['allocated']
@flex = options['flex']
end

def save()
  sql = "INSERT INTO partloads (pvolume, pcollect_x, pcollect_y, pdeliver_x, pdeliver_y, allocated, flex
  ) VALUES (
  '#{@pvolume}', '#{@pcollect_x}', '#{@pcollect_y}', '#{@pdeliver_x}', '#{@pdeliver_y}', '#{@allocated}', '#{@flex}') RETURNING *;"
  @id = SqlRunner.run(sql).first['id'].to_i
  end



  end