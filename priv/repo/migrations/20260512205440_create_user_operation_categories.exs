defmodule KaneIranaiApi.Repo.Migrations.CreateUserOperationCategories do
  use Ecto.Migration

  def change do
    create table(:user_operation_categories, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :operation_category_id, references(:operation_categories, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:user_operation_categories, [:user_id])
    create index(:user_operation_categories, [:operation_category_id])
  end
end
