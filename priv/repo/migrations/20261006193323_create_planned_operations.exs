defmodule KaneIranaiApi.Repo.Migrations.CreatePlannedOperations do
  use Ecto.Migration
  import EctoEnumMigration

  alias KaneIranaiApi.PlannedOperations.PlannedOperation

  def change do
    create_type(:planned_operation_status, PlannedOperation.get_field_enum(:status))
    create_type(:planned_operation_type, PlannedOperation.get_field_enum(:type))

    create table(:planned_operations, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :amount, :integer
      add :status, :planned_operation_status
      add :type, :planned_operation_type
      add :plan_id, references(:budget_plans, on_delete: :nothing, type: :binary_id)
      add :operation_category_id, references(:operation_categories, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:planned_operations, [:plan_id])
    create index(:planned_operations, [:operation_category_id])
  end
end
