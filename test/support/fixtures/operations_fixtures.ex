defmodule KaneIranaiApi.OperationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `KaneIranaiApi.Operations` context.
  """

  @doc """
  Generate a operation.
  """
  def operation_fixture(attrs \\ %{}) do
    {:ok, operation} =
      attrs
      |> Enum.into(%{
        amount: 42,
        description: "some description",
        processed_at: ~N[2026-10-05 16:53:00],
        type: :increase
      })
      |> KaneIranaiApi.Operations.create_operation()

    operation
  end
end
