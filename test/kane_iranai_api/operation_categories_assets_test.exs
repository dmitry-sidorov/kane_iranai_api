defmodule KaneIranaiApi.OperationCategoriesAssetsTest do
  use KaneIranaiApi.DataCase

  alias KaneIranaiApi.OperationCategoriesAssets

  describe "operation_categories_assets" do
    alias KaneIranaiApi.OperationCategoriesAssets.OperationCategoryAsset

    import KaneIranaiApi.OperationCategoriesAssetsFixtures

    @invalid_attrs %{title: nil}

    test "list_operation_categories_assets/0 returns all operation_categories_assets" do
      operation_category_asset = operation_category_asset_fixture()
      assert OperationCategoriesAssets.list_operation_categories_assets() == [operation_category_asset]
    end

    test "get_operation_category_asset!/1 returns the operation_category_asset with given id" do
      operation_category_asset = operation_category_asset_fixture()
      assert OperationCategoriesAssets.get_operation_category_asset!(operation_category_asset.id) == operation_category_asset
    end

    test "create_operation_category_asset/1 with valid data creates a operation_category_asset" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %OperationCategoryAsset{} = operation_category_asset} = OperationCategoriesAssets.create_operation_category_asset(valid_attrs)
      assert operation_category_asset.title == "some title"
    end

    test "create_operation_category_asset/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = OperationCategoriesAssets.create_operation_category_asset(@invalid_attrs)
    end

    test "update_operation_category_asset/2 with valid data updates the operation_category_asset" do
      operation_category_asset = operation_category_asset_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %OperationCategoryAsset{} = operation_category_asset} = OperationCategoriesAssets.update_operation_category_asset(operation_category_asset, update_attrs)
      assert operation_category_asset.title == "some updated title"
    end

    test "update_operation_category_asset/2 with invalid data returns error changeset" do
      operation_category_asset = operation_category_asset_fixture()
      assert {:error, %Ecto.Changeset{}} = OperationCategoriesAssets.update_operation_category_asset(operation_category_asset, @invalid_attrs)
      assert operation_category_asset == OperationCategoriesAssets.get_operation_category_asset!(operation_category_asset.id)
    end

    test "delete_operation_category_asset/1 deletes the operation_category_asset" do
      operation_category_asset = operation_category_asset_fixture()
      assert {:ok, %OperationCategoryAsset{}} = OperationCategoriesAssets.delete_operation_category_asset(operation_category_asset)
      assert_raise Ecto.NoResultsError, fn -> OperationCategoriesAssets.get_operation_category_asset!(operation_category_asset.id) end
    end

    test "change_operation_category_asset/1 returns a operation_category_asset changeset" do
      operation_category_asset = operation_category_asset_fixture()
      assert %Ecto.Changeset{} = OperationCategoriesAssets.change_operation_category_asset(operation_category_asset)
    end
  end
end
