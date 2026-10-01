defmodule KaneIranaiApi.OperationCategoriesFixtures do
  alias KaneIranaiApi.OperationCategories
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
        purpose: :mandatory,
        title: "some title"
      })
      |> KaneIranaiApi.OperationCategories.create_operation_category()

    operation_category
  end

  def get_mock_operation_categories() do
    [
      %OperationCategory{title: "Groceries", purpose: "desirable", type: "public" },
      %OperationCategory{title: "Restaurant", purpose: "desirable", type: "public" },
      %OperationCategory{title: "Car", purpose: "desirable", type: "public" },
    ]
  end

  def seed_operation_categories do
    for operation_category <- get_mock_operation_categories() do
      operation_category
      |> Map.from_struct()
      |> OperationCategories.create_operation_category()
    end
  end

  def seed_private_operation_categories do
    for operation_category <- get_mock_operation_categories() do
      operation_category
      |> Map.from_struct()
      |> Map.put(:type, "private")
      |> OperationCategories.create_operation_category()
    end
  end
end
