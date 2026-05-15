defmodule KaneIranaiApi.OperationCategoriesFixtures do
  alias KaneIranaiApi.OperationCategories.OperationCategory

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

  def get_mock_operation_categories() do
    [
      %OperationCategory{title: "Groceries", purpose: "secondary", type: "public" },
      %OperationCategory{title: "Restaurant", purpose: "secondary", type: "public" },
      %OperationCategory{title: "Car", purpose: "secondary", type: "public" },
    ]
  end
end
