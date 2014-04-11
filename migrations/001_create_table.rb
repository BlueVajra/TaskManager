Sequel.migration {
  up do
    create_table(:tasks) do
      primary_key :id
      String :task
    end
  end
  down do
    drop_table :tasks
  end
}