require 'singleton'

class ProjectRepository
  include Singleton

  def initialize
    @db = DB[:projects]
  end

  def add(project)
    @db.insert(project_name: project)
  end

  def all
    @db.all
  end

  def first
    @db.first
  end

  def delete(id)
    get(id).delete
  end

  def find(id)
    @db[project_id: id]
  end

  def get(id)
    @db.where('project_id =?', id)
  end

  def get_name(id)
    #get(id)[:project_name]
    @db[project_id: id][:project_name]
  end


end