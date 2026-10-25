defmodule KaneIranaiApiWeb.BudgetPlanController do
  use KaneIranaiApiWeb, :controller
  import KaneIranaiApiWeb.Auth.AuthorizedPlug

  alias KaneIranaiApi.BudgetPlans
  alias KaneIranaiApi.BudgetPlans.BudgetPlan

  action_fallback KaneIranaiApiWeb.FallbackController
  # plug :is_authorized_user when action in [:index, :create, :show, :update, :delete]

  def index(conn, _params) do
    budget_plans = BudgetPlans.list_budget_plans_by_user(conn.assigns.user)
    render(conn, :index, budget_plans: budget_plans)
  end

  def create(conn, _params) do
    user = conn.assigns.user
    conn.params |> dbg()
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


  @spec show(any(), any()) :: nil
  def show(conn, _params) do

  end



  def update(conn, _params) do

  end

  def delete(conn, _params) do

  end
end
