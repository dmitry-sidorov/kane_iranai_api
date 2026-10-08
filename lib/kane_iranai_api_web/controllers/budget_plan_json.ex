defmodule KaneIranaiApiWeb.BudgetPlanJSON do
  alias KaneIranaiApi.BudgetPlans.BudgetPlan

  @doc """
  Renders a list of budget plans.
  """
  def index(%{budget_plans: plans}) do
    %{data: for(plan <- plans, do: data(plan))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  defp data(%BudgetPlan{} = plan) do
    %{
      start_date: plan.start_date,
      period_in_days: plan.period_in_days,
      description: plan.description,
      planned_operations: plan.planned_operations,
    }
  end
end
