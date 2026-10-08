defmodule KaneIranaiApiWeb.BudgetPlanController do
  use KaneIranaiApiWeb, :controller
  # import KaneIranaiApiWeb.Auth.AuthorizedPlug

  alias KaneIranaiApi.BudgetPlans

  action_fallback KaneIranaiApiWeb.FallbackController
  # plug :is_authorized_user when action in [:index, :show, :update, :delete]

  def index(conn, _params) do
    budget_plans = BudgetPlans.list_budget_plans()
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
