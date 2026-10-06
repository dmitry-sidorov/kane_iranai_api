defmodule KaneIranaiApi.Repo.Migrations.CreateOperations do
  use Ecto.Migration
  import EctoEnumMigration

  alias KaneIranaiApi.Operations.Operation

  def change do
    create_type(:operation_type, Operation.get_field_enum(:type))

    create table(:operations, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :amount, :integer
      add :description, :string
      add :processed_at, :naive_datetime
      add :type, :operation_type
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :debit_account_id, references(:debit_accounts, on_delete: :nothing, type: :binary_id)
      add :operation_category_id, references(:operation_categories, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:operations, [:user_id])
    create index(:operations, [:debit_account_id])
    create index(:operations, [:operation_category_id])
  end
end
