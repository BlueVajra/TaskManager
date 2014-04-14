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
    @db.where('id =?', id).delete
  end
end