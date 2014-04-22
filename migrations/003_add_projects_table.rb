Sequel.migration {
  up do
    create_table(:projects) do
      primary_key :project_id
      String :project_name
    end
    alter_table(:tasks) do
      add_foreign_key :project_id, :projects
    end
  end
  down do
    drop_table :projects
    alter_table(:tasks) do
      drop_foreign_key :project_id
    end
  end
}