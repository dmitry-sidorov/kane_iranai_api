defmodule KaneIranaiApi.UserOperationCategories.UserOperationCategory do
  use Ecto.Schema
  import Ecto.Changeset

  alias KaneIranaiApi.Users.User
  alias KaneIranaiApi.OperationCategories.OperationCategory

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "user_operation_categories" do
    belongs_to :user, User
    belongs_to :operation_category, OperationCategory

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user_operation_category, attrs \\ %{}) do
    user_operation_category
    |> cast(attrs, [])
  end
end
