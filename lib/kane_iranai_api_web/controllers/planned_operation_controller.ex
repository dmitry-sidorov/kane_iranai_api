defmodule KaneIranaiApiWeb.PlannedOperationController do
  use KaneIranaiApiWeb, :controller
  use PhoenixSwagger

  alias KaneIranaiApi.OperationCategories
  alias KaneIranaiApi.PlannedOperations
  alias KaneIranaiApi.PlannedOperations.PlannedOperation
  alias KaneIranaiApi.BudgetPlans

  action_fallback KaneIranaiApiWeb.FallbackController

  def swagger_definitions do
    %{
      PlannedOperation: swagger_schema do
        title "Planned operation"
        properties do
          id :string, "Planned operation ID", format: :uuid, required: true
          amount :integer, "Amount", required: true
          status :string, "Status", required: true, enum: ["canceled", "draft", "pending", "resolved"]
          type :string, "Type", required: true, enum: ["increase", "decrease"]
          budget_plan_id :string, "Budget plan ID", format: :uuid, required: true
          operation_category_id :string, "Operation category ID", format: :uuid, required: true
        end
      end,
      PlannedOperationResponse: swagger_schema do
        title "Planned operation response"
        properties do
          planned_operation Schema.ref(:PlannedOperation), "Planned operation", required: true
        end
      end,
      PlannedOperationCreateRequest: swagger_schema do
        title "Create planned operation request"
        properties do
          budget_plan_id :string, "Budget plan ID. Must belong to the current user.", format: :uuid, required: true
          operation_category_id :string, "Operation category ID. Must belong to the current user.", format: :uuid, required: true
          amount :integer, "Amount", required: true
          status :string, "Status", required: true, enum: ["canceled", "draft", "pending", "resolved"]
          type :string, "Type", required: true, enum: ["increase", "decrease"]
        end
      end
    }
  end

  swagger_path :create do
    summary "Create planned operation"
    description "Creates a planned operation when the budget plan and operation category belong to the authenticated user."
    tag "Planned Operations"
    consumes "application/json"
    produces "application/json"
    security [%{Bearer: []}]
    parameter :body, :body, Schema.ref(:PlannedOperationCreateRequest), "Planned operation", required: true
    response 201, "Created", :PlannedOperationResponse
    response 401, "Unauthorized", :AuthError
    response 404, "Budget plan or operation category not found", :NotFoundError
  end

  def create(conn, params) do
    user = conn.assigns.user
    budget_plan_id = params["budget_plan_id"]
    operation_category_id = params["operation_category_id"]
    planned_operation_params = %{
      amount: params["amount"],
      status: params["status"],
      type: params["type"],
    }
    budget_plan = BudgetPlans.get_budget_plan!(budget_plan_id)
    user_operation_category = OperationCategories.get_operation_category!(operation_category_id)

    if budget_plan.user.id == user.id && user_operation_category.user.id == user.id do
      {:ok, %PlannedOperation{} = planned_operation} = PlannedOperations.create_planned_operation(budget_plan, user_operation_category, planned_operation_params)
      conn
      |> put_status(:created)
      |> render(:show, planned_operation: planned_operation)
    end
  end
end
