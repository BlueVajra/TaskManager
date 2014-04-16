Sequel.migration {
  up do
    add_column :tasks, :completed, TrueClass, :default => false
  end
  down do
    drop_column :tasks, :completed
  end
}