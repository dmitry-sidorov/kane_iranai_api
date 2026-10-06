defmodule KaneIranaiApi.OperationsLinksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `KaneIranaiApi.OperationsLinks` context.
  """

  @doc """
  Generate a operations_link.
  """
  def operations_link_fixture(attrs \\ %{}) do
    {:ok, operations_link} =
      attrs
      |> Enum.into(%{

      })
      |> KaneIranaiApi.OperationsLinks.create_operations_link()

    operations_link
  end
end
