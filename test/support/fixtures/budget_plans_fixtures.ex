defmodule KaneIranaiApi.BudgetPlansFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `KaneIranaiApi.BudgetPlans` context.
  """

  @doc """
  Generate a budget_plan.
  """
  def budget_plan_fixture(attrs \\ %{}) do
    {:ok, budget_plan} =
      attrs
      |> Enum.into(%{
        description: "some description",
        period_in_days: 42,
        start_date: ~N[2026-10-05 18:53:00]
      })
      |> KaneIranaiApi.BudgetPlans.create_budget_plan()

    budget_plan
  end
end
