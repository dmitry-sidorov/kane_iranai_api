defmodule KaneIranaiApiWeb.BudgetPlanController do
  use KaneIranaiApiWeb, :controller
  import KaneIranaiApiWeb.Auth.AuthorizedPlug

  alias KaneIranaiApi.BudgetPlans

  action_fallback KaneIranaiApiWeb.FallbackController
  # plug :is_authorized_user when action in [:index, :create, :show, :update, :delete]

  def index(conn, _params) do
    conn |> dbg()
    budget_plans = BudgetPlans.list_budget_plans_by_user(conn.assigns.user)
    render(conn, :index, budget_plans: budget_plans)
  end

  def create(conn) do

  end


  def show(conn) do

  end



  def update(conn) do

  end

  def delete(conn) do

  end
end
