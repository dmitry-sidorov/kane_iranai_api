defmodule KaneIranaiApi.OperationCategoriesAssets.OperationCategoryAsset do
  use Ecto.Schema
  import Ecto.Changeset

  alias KaneIranaiApi.Users.User
  alias KaneIranaiApi.OperationCategories.OperationCategory

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "operation_categories_assets" do
    field :title, :string
    belongs_to :user, User
    belongs_to :operation_category, OperationCategory

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(operation_category_asset, attrs) do
    operation_category_asset
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
