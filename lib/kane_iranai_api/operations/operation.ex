defmodule KaneIranaiApi.Operations.Operation do
  use Ecto.Schema
  import Ecto.Changeset

  alias KaneIranaiApi.Users.User
  alias KaneIranaiApi.DebitAccounts.DebitAccount
  alias KaneIranaiApi.OperationCategories.OperationCategory
  alias KaneIranaiApi.Operations.Operation
  alias KaneIranaiApi.OperationsLinks.OperationsLink

  @operation_type_enum [:increase, :decrease]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "operations" do
    field :amount, :integer
    field :description, :string
    field :processed_at, :naive_datetime
    field :type, Ecto.Enum, values: @operation_type_enum
    belongs_to :user, User
    belongs_to :debit_account, DebitAccount
    belongs_to :operation_category, OperationCategory
    many_to_many :planned_operations, Operation, join_through: OperationsLink

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(operation, attrs) do
    operation
    |> cast(attrs, [:amount, :description, :processed_at, :type])
    |> validate_required([:amount, :description, :processed_at, :type])
  end

  @doc false
  def get_field_enum(:type), do: @operation_type_enum
end
