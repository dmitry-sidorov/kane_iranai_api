defmodule KaneIranaiApi.PlannedOperations.PlannedOperation do
  use Ecto.Schema
  import Ecto.Changeset

  alias KaneIranaiApi.BudgetPlans.BudgetPlan
  alias KaneIranaiApi.Operations.Operation
  alias KaneIranaiApi.OperationCategories.OperationCategory
  alias KaneIranaiApi.OperationsLinks.OperationsLink

  @planned_operation_status_enum [:canceled, :draft, :pending, :resolved]
  @planned_operation_type_enum [:increase, :decrease]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "planned_operations" do
    field :amount, :integer
    field :status, Ecto.Enum, values: @planned_operation_status_enum
    field :type, Ecto.Enum, values: @planned_operation_type_enum
    belongs_to :budget_plan, BudgetPlan
    belongs_to :operation_category, OperationCategory
    many_to_many :operations, Operation, join_through: OperationsLink

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(planned_operation, attrs) do
    planned_operation
    |> cast(attrs, [:amount, :status, :type])
    |> validate_required([:amount, :status, :type])
  end

  @doc false
  def get_field_enum(:status), do: @planned_operation_status_enum

  @doc false
  def get_field_enum(:type), do: @planned_operation_type_enum
end
