defmodule KaneIranaiApi.Repo.Migrations.CreateOperationCategoriesAssets do
  use Ecto.Migration

  def change do
    create table(:operation_categories_assets, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :owner_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :operation_category_id, references(:operation_categories, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:operation_categories_assets, [:owner_id])
    create index(:operation_categories_assets, [:operation_category_id])
  end
end
