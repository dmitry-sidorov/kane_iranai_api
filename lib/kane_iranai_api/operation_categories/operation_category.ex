defmodule KaneIranaiApi.OperationCategories.OperationCategory do
  use Ecto.Schema
  import Ecto.Changeset

  alias KaneIranaiApi.Users.User
  alias KaneIranaiApi.UserOperationCategories.UserOperationCategory
  alias KaneIranaiApi.Operations.Operation
  alias KaneIranaiApi.PlannedOperations.PlannedOperation

  @operation_category_type_enum [:public, :private]
  @operation_category_purpose_enum [:mandatory, :desirable, :optional]

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "operation_categories" do
    field :title, :string
    field :purpose, Ecto.Enum, values: @operation_category_purpose_enum
    field :type, Ecto.Enum, values: @operation_category_type_enum
    many_to_many :users, User, join_through: UserOperationCategory
    has_many :operations, Operation
    has_many :planned_operations, PlannedOperation

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(operation_category, attrs) do
    operation_category
    |> cast(attrs, [:title, :purpose, :type])
    |> validate_required([:title, :purpose, :type])
  end

  @doc false
  def get_field_enum(:type), do: @operation_category_type_enum

  @doc false
  def get_field_enum(:purpose), do: @operation_category_purpose_enum
end
