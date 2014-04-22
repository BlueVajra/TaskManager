require 'singleton'

class TaskRepository
  include Singleton

  def initialize
    @db = DB[:tasks]
  end

  def add(task, project_id = 1)
    @db.insert(task: task, project_id: project_id)
  end

  def tasks
    @db.to_a
  end

  def delete(id)
    get(id).delete
  end

  def find(id)
    #@db.where('id =?', id)
    @db[id: id]
  end

  def completed?(id)
    @db[id: id][:completed]
  end

  def complete(id)
    completed?(id) ? get(id).update(completed:false) : get(id).update(completed:true)
  end

  private
  def get(id)
    @db.where('id =?', id)
  end
end
