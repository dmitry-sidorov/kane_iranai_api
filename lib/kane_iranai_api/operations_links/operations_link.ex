defmodule KaneIranaiApi.OperationsLinks.OperationsLink do
  use Ecto.Schema
  import Ecto.Changeset

  alias KaneIranaiApi.Operations.Operation
  alias KaneIranaiApi.PlannedOperations.PlannedOperation

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "operations_links" do
    belongs_to :operation, Operation
    belongs_to :planned_operation, PlannedOperation

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(operations_link, attrs) do
    operations_link
    |> cast(attrs, [])
    |> validate_required([])
  end
end
