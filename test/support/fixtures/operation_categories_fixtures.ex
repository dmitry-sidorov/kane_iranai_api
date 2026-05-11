defmodule KaneIranaiApi.OperationCategoriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `KaneIranaiApi.OperationCategories` context.
  """

  @doc """
  Generate a operation_category.
  """
  def operation_category_fixture(attrs \\ %{}) do
    {:ok, operation_category} =
      attrs
      |> Enum.into(%{
        purpose: :primary,
        title: "some title"
      })
      |> KaneIranaiApi.OperationCategories.create_operation_category()

    operation_category
  end
end
