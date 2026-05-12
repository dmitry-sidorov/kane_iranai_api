defmodule KaneIranaiApi.Repo.Migrations.CreateOperationCategories do
  use Ecto.Migration
  import EctoEnumMigration

  alias KaneIranaiApi.OperationCategories.OperationCategory

  def change do
    create_type(:operation_purpose, OperationCategory.get_field_enum(:purpose))
    create_type(:operation_type, OperationCategory.get_field_enum(:type))

    create table(:operation_categories, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :purpose, :operation_purpose
      add :type, :operation_type

      timestamps(type: :utc_datetime)
    end
  end
end
