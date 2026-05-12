defmodule KaneIranaiApi.OperationCategoriesAssetsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `KaneIranaiApi.OperationCategoriesAssets` context.
  """

  @doc """
  Generate a operation_category_asset.
  """
  def operation_category_asset_fixture(attrs \\ %{}) do
    {:ok, operation_category_asset} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> KaneIranaiApi.OperationCategoriesAssets.create_operation_category_asset()

    operation_category_asset
  end
end
