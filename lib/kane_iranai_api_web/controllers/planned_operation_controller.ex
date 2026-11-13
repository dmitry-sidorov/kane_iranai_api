defmodule KaneIranaiApiWeb.PlannedOperationController do
  use KaneIranaiApiWeb, :controller
  use KaneIranaiApiWeb.Swagger.PlannedOperation

  alias KaneIranaiApi.OperationCategories
  alias KaneIranaiApi.PlannedOperations
  alias KaneIranaiApi.PlannedOperations.PlannedOperation
  alias KaneIranaiApi.BudgetPlans

  action_fallback KaneIranaiApiWeb.FallbackController

  def index(conn, %{"budget_plan_id " => budget_plan_id}) do
    budget_plan = BudgetPlans.get_budget_plan!(budget_plan_id) |> dbg()
    user = conn.assigns.user |> dbg()

    if budget_plan.user.id == user.id do
      planned_operations = PlannedOperations.list_planned_operations_by_budget_plan(budget_plan)
      render(conn, :index, planned_operations: planned_operations)
    end
  end

  def create(conn, params) do
    user = conn.assigns.user
    budget_plan_id = params["budget_plan_id"]
    operation_category_id = params["operation_category_id"]

    planned_operation_params = %{
      amount: params["amount"],
      status: params["status"],
      type: params["type"]
    }

    budget_plan = BudgetPlans.get_budget_plan!(budget_plan_id)
    user_operation_category = OperationCategories.get_operation_category!(operation_category_id)

    if budget_plan.user.id == user.id && user_operation_category.user.id == user.id do
      {:ok, %PlannedOperation{} = planned_operation} =
        PlannedOperations.create_planned_operation(
          budget_plan,
          user_operation_category,
          planned_operation_params
        )

      conn
      |> put_status(:created)
      |> render(:show, planned_operation: planned_operation)
    end
  end
end
