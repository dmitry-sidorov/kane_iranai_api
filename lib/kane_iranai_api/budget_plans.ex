defmodule KaneIranaiApi.BudgetPlans do
  @moduledoc """
  The BudgetPlans context.
  """

  import Ecto.Query, warn: false
  alias KaneIranaiApi.Repo

  alias KaneIranaiApi.BudgetPlans.BudgetPlan

  @doc """
  Returns the list of budget_plans.

  ## Examples

      iex> list_budget_plans()
      [%BudgetPlan{}, ...]

  """
  def list_budget_plans do
    Repo.all(BudgetPlan)
  end

  @doc """
  Gets a single budget_plan.

  Raises `Ecto.NoResultsError` if the Budget plan does not exist.

  ## Examples

      iex> get_budget_plan!(123)
      %BudgetPlan{}

      iex> get_budget_plan!(456)
      ** (Ecto.NoResultsError)

  """
  def get_budget_plan!(id), do: Repo.get!(BudgetPlan, id)

  @doc """
  Creates a budget_plan.

  ## Examples

      iex> create_budget_plan(%{field: value})
      {:ok, %BudgetPlan{}}

      iex> create_budget_plan(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_budget_plan(attrs) do
    %BudgetPlan{}
    |> BudgetPlan.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a budget_plan.

  ## Examples

      iex> update_budget_plan(budget_plan, %{field: new_value})
      {:ok, %BudgetPlan{}}

      iex> update_budget_plan(budget_plan, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_budget_plan(%BudgetPlan{} = budget_plan, attrs) do
    budget_plan
    |> BudgetPlan.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a budget_plan.

  ## Examples

      iex> delete_budget_plan(budget_plan)
      {:ok, %BudgetPlan{}}

      iex> delete_budget_plan(budget_plan)
      {:error, %Ecto.Changeset{}}

  """
  def delete_budget_plan(%BudgetPlan{} = budget_plan) do
    Repo.delete(budget_plan)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking budget_plan changes.

  ## Examples

      iex> change_budget_plan(budget_plan)
      %Ecto.Changeset{data: %BudgetPlan{}}

  """
  def change_budget_plan(%BudgetPlan{} = budget_plan, attrs \\ %{}) do
    BudgetPlan.changeset(budget_plan, attrs)
  end
end
