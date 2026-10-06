defmodule KaneIranaiApi.Repo.Migrations.CreateOperationsLinks do
  use Ecto.Migration

  def change do
    create table(:operations_links, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :operation_id, references(:operations, on_delete: :nothing, type: :binary_id)
      add :planned_operation_id, references(:planned_operations, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:operations_links, [:operation_id])
    create index(:operations_links, [:planned_operation_id])
  end
end
