defmodule KaneIranaiApiWeb.BudgetPlanJSON do
  alias KaneIranaiApi.BudgetPlans.BudgetPlan

  @doc """
  Renders a list of budget plans.
  """
  def index(%{budget_plans: plans}) do
    %{budget_plans: for(plan <- plans, do: data(plan))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{budget_plan: budget_plan}) do
    %{budget_plan: data(budget_plan)}
  end

  defp data(%BudgetPlan{} = plan) do
    %{
      start_date: plan.start_date,
      id: plan.id,
      period_in_days: plan.period_in_days,
      description: plan.description,
      planned_operations: plan.planned_operations,
    }
  end
end
