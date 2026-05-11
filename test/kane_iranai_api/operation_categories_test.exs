defmodule KaneIranaiApi.OperationCategoriesTest do
  use KaneIranaiApi.DataCase

  alias KaneIranaiApi.OperationCategories

  describe "operation_categories" do
    alias KaneIranaiApi.OperationCategories.OperationCategory

    import KaneIranaiApi.OperationCategoriesFixtures

    @invalid_attrs %{title: nil, purpose: nil}

    test "list_operation_categories/0 returns all operation_categories" do
      operation_category = operation_category_fixture()
      assert OperationCategories.list_operation_categories() == [operation_category]
    end

    test "get_operation_category!/1 returns the operation_category with given id" do
      operation_category = operation_category_fixture()
      assert OperationCategories.get_operation_category!(operation_category.id) == operation_category
    end

    test "create_operation_category/1 with valid data creates a operation_category" do
      valid_attrs = %{title: "some title", purpose: :primary}

      assert {:ok, %OperationCategory{} = operation_category} = OperationCategories.create_operation_category(valid_attrs)
      assert operation_category.title == "some title"
      assert operation_category.purpose == :primary
    end

    test "create_operation_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = OperationCategories.create_operation_category(@invalid_attrs)
    end

    test "update_operation_category/2 with valid data updates the operation_category" do
      operation_category = operation_category_fixture()
      update_attrs = %{title: "some updated title", purpose: :secondary}

      assert {:ok, %OperationCategory{} = operation_category} = OperationCategories.update_operation_category(operation_category, update_attrs)
      assert operation_category.title == "some updated title"
      assert operation_category.purpose == :secondary
    end

    test "update_operation_category/2 with invalid data returns error changeset" do
      operation_category = operation_category_fixture()
      assert {:error, %Ecto.Changeset{}} = OperationCategories.update_operation_category(operation_category, @invalid_attrs)
      assert operation_category == OperationCategories.get_operation_category!(operation_category.id)
    end

    test "delete_operation_category/1 deletes the operation_category" do
      operation_category = operation_category_fixture()
      assert {:ok, %OperationCategory{}} = OperationCategories.delete_operation_category(operation_category)
      assert_raise Ecto.NoResultsError, fn -> OperationCategories.get_operation_category!(operation_category.id) end
    end

    test "change_operation_category/1 returns a operation_category changeset" do
      operation_category = operation_category_fixture()
      assert %Ecto.Changeset{} = OperationCategories.change_operation_category(operation_category)
    end
  end
end
