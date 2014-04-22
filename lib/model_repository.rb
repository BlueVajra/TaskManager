class Project < Sequel::Model(:projects)
  one_to_many :tasks
end

class Task < Sequel::Model(:tasks)
  many_to_one :project
end