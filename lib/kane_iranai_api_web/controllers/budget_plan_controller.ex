defmodule KaneIranaiApiWeb.BudgetPlanController do
  use KaneIranaiApiWeb, :controller

  alias KaneIranaiApi.BudgetPlans
  alias KaneIranaiApi.BudgetPlans.BudgetPlan

  action_fallback KaneIranaiApiWeb.FallbackController

  def index(conn, _params) do
    budget_plans = BudgetPlans.list_budget_plans_by_user(conn.assigns.user)
    render(conn, :index, budget_plans: budget_plans)
  end

  def create(conn, _params) do
    user = conn.assigns.user
    budget_params = %{
      start_date: Date.from_iso8601!(conn.params["start_date"]),
      description: conn.params["description"],
      period_in_days: conn.params["period_in_days"],
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
