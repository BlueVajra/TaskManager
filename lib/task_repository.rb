require 'sequel'

class TaskRepository
  def initialize(db)
    @db = db[:tasks]
  end

  def add(task)
    @db.insert(task: task)
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
