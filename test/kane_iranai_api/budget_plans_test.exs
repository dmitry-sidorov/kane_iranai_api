defmodule KaneIranaiApi.BudgetPlansTest do
  use KaneIranaiApi.DataCase

  alias KaneIranaiApi.BudgetPlans

  describe "budget_plans" do
    alias KaneIranaiApi.BudgetPlans.BudgetPlan

    import KaneIranaiApi.BudgetPlansFixtures

    @invalid_attrs %{description: nil, start_date: nil, period_in_days: nil}

    test "list_budget_plans/0 returns all budget_plans" do
      budget_plan = budget_plan_fixture()
      assert BudgetPlans.list_budget_plans() == [budget_plan]
    end

    test "get_budget_plan!/1 returns the budget_plan with given id" do
      budget_plan = budget_plan_fixture()
      assert BudgetPlans.get_budget_plan!(budget_plan.id) == budget_plan
    end

    test "create_budget_plan/1 with valid data creates a budget_plan" do
      valid_attrs = %{description: "some description", start_date: ~N[2026-10-05 18:53:00], period_in_days: 42}

      assert {:ok, %BudgetPlan{} = budget_plan} = BudgetPlans.create_budget_plan(valid_attrs)
      assert budget_plan.description == "some description"
      assert budget_plan.start_date == ~N[2026-10-05 18:53:00]
      assert budget_plan.period_in_days == 42
    end

    test "create_budget_plan/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BudgetPlans.create_budget_plan(@invalid_attrs)
    end

    test "update_budget_plan/2 with valid data updates the budget_plan" do
      budget_plan = budget_plan_fixture()
      update_attrs = %{description: "some updated description", start_date: ~N[2026-10-06 18:53:00], period_in_days: 43}

      assert {:ok, %BudgetPlan{} = budget_plan} = BudgetPlans.update_budget_plan(budget_plan, update_attrs)
      assert budget_plan.description == "some updated description"
      assert budget_plan.start_date == ~N[2026-10-06 18:53:00]
      assert budget_plan.period_in_days == 43
    end

    test "update_budget_plan/2 with invalid data returns error changeset" do
      budget_plan = budget_plan_fixture()
      assert {:error, %Ecto.Changeset{}} = BudgetPlans.update_budget_plan(budget_plan, @invalid_attrs)
      assert budget_plan == BudgetPlans.get_budget_plan!(budget_plan.id)
    end

    test "delete_budget_plan/1 deletes the budget_plan" do
      budget_plan = budget_plan_fixture()
      assert {:ok, %BudgetPlan{}} = BudgetPlans.delete_budget_plan(budget_plan)
      assert_raise Ecto.NoResultsError, fn -> BudgetPlans.get_budget_plan!(budget_plan.id) end
    end

    test "change_budget_plan/1 returns a budget_plan changeset" do
      budget_plan = budget_plan_fixture()
      assert %Ecto.Changeset{} = BudgetPlans.change_budget_plan(budget_plan)
    end
  end
end
