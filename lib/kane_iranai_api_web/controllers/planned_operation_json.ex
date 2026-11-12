defmodule KaneIranaiApiWeb.PlannedOperationJSON do
  alias KaneIranaiApi.PlannedOperations.PlannedOperation

  @doc """
  Renders a planned operation.
  """
  def show(%{planned_operation: planned_operation}) do
    %{planned_operation: data(planned_operation)}
  end

  defp data(%PlannedOperation{} = planned_operation) do
    %{
      id: planned_operation.id,
      amount: planned_operation.amount,
      status: planned_operation.status,
      type: planned_operation.type,
      budget_plan_id: planned_operation.budget_plan_id,
      operation_category_id: planned_operation.operation_category_id,
    }
  end
end
