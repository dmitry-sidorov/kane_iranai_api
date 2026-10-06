defmodule KaneIranaiApi.PlannedOperationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `KaneIranaiApi.PlannedOperations` context.
  """

  @doc """
  Generate a planned_operation.
  """
  def planned_operation_fixture(attrs \\ %{}) do
    {:ok, planned_operation} =
      attrs
      |> Enum.into(%{
        amount: 42,
        status: :canceled,
        type: :increase
      })
      |> KaneIranaiApi.PlannedOperations.create_planned_operation()

    planned_operation
  end
end
