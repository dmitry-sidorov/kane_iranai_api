defmodule KaneIranaiApiWeb.BudgetPlanController do
  use KaneIranaiApiWeb, :controller
  use PhoenixSwagger

  alias KaneIranaiApi.BudgetPlans
  alias KaneIranaiApi.BudgetPlans.BudgetPlan

  action_fallback KaneIranaiApiWeb.FallbackController

  def swagger_definitions do
    %{
      BudgetPlan: swagger_schema do
        title "Budget plan"
        properties do
          id :string, "Budget plan ID", format: :uuid, required: true
          start_date :string, "Start date", format: :date, required: true
          period_in_days :integer, "Period length in days", required: true
          description :string, "Description", required: true
          planned_operations Schema.array(:PlannedOperation), "Planned operations"
        end
      end,
      BudgetPlanResponse: swagger_schema do
        title "Budget plan response"
        properties do
          budget_plan Schema.ref(:BudgetPlan), "Budget plan", required: true
        end
      end,
      BudgetPlanList: swagger_schema do
        title "Budget plan list"
        properties do
          budget_plans Schema.array(:BudgetPlan), "Budget plans", required: true
        end
      end,
      BudgetPlanCreateRequest: swagger_schema do
        title "Create budget plan request"
        properties do
          start_date :string, "Start date", format: :date, required: true
          period_in_days :integer, "Period length in days", required: true
          description :string, "Description", required: true
        end
      end,
      BudgetPlanPayload: swagger_schema do
        title "Budget plan payload"
        properties do
          start_date :string, "Start date", format: :date
          period_in_days :integer, "Period length in days"
          description :string, "Description"
        end
      end,
      BudgetPlanUpdateRequest: swagger_schema do
        title "Update budget plan request"
        properties do
          id :string, "Budget plan ID", format: :uuid, required: true
          payload Schema.ref(:BudgetPlanPayload), "Fields to update", required: true
        end
      end
    }
  end

  swagger_path :index do
    summary "List budget plans"
    description "Lists budget plans belonging to the authenticated user."
    tag "Budget Plans"
    produces "application/json"
    security [%{Bearer: []}]
    response 200, "Budget plans", :BudgetPlanList
    response 401, "Unauthorized", :AuthError
  end

  swagger_path :show do
    summary "Show budget plan"
    tag "Budget Plans"
    produces "application/json"
    security [%{Bearer: []}]
    parameter :id, :path, :string, "Budget plan ID", required: true, format: :uuid
    response 200, "Budget plan", :BudgetPlanResponse
    response 401, "Unauthorized", :AuthError
    response 404, "Not found", :NotFoundError
  end

  swagger_path :create do
    summary "Create budget plan"
    description "Creates a budget plan for the authenticated user."
    tag "Budget Plans"
    consumes "application/json"
    produces "application/json"
    security [%{Bearer: []}]
    parameter :body, :body, Schema.ref(:BudgetPlanCreateRequest), "Budget plan", required: true
    response 201, "Created", :BudgetPlanResponse
    response 401, "Unauthorized", :AuthError
    response 422, "Validation error", :ChangesetError
  end

  swagger_path :update do
    summary "Update budget plan"
    tag "Budget Plans"
    consumes "application/json"
    produces "application/json"
    security [%{Bearer: []}]
    parameter :body, :body, Schema.ref(:BudgetPlanUpdateRequest), "Update payload", required: true
    response 200, "Updated budget plan", :BudgetPlanResponse
    response 401, "Unauthorized", :AuthError
    response 404, "Not found", :NotFoundError
  end

  swagger_path :delete do
    summary "Delete budget plan"
    tag "Budget Plans"
    security [%{Bearer: []}]
    parameter :id, :query, :string, "Budget plan ID", required: true, format: :uuid
    response 204, "Deleted"
    response 401, "Unauthorized", :AuthError
    response 404, "Not found", :NotFoundError
  end

  def index(conn, _params) do
    budget_plans = BudgetPlans.list_budget_plans_by_user(conn.assigns.user)
    render(conn, :index, budget_plans: budget_plans)
  end

  def create(conn, params) do
    user = conn.assigns.user
    budget_params = %{
      start_date: Date.from_iso8601!(params["start_date"]),
      description: params["description"],
      period_in_days: params["period_in_days"],
    }
    with {:ok, %BudgetPlan{} = budget_plan} <- BudgetPlans.create_budget_plan(user, budget_params) do
      conn
      |> put_status(:created)
      |> render(:show, budget_plan: budget_plan)
    end
  end


  def show(conn, %{"id" => id}) do
    budget_plan = BudgetPlans.get_budget_plan!(id)
    render(conn, :show, budget_plan: budget_plan)
  end

  def update(conn, %{"id" => id, "payload" => payload}) do
    budget_plan = BudgetPlans.get_budget_plan!(id)
    {:ok, updated_budget_plan} = BudgetPlans.update_budget_plan(budget_plan, payload)
    render(conn, :show, budget_plan: updated_budget_plan)
  end

  def delete(conn, %{"id" => id}) do
    budget_plan = BudgetPlans.get_budget_plan!(id)
    {:ok, _} = BudgetPlans.delete_budget_plan(budget_plan)
    send_resp(conn, :no_content, "Budget plans has been deleted successfully")
  end
end
