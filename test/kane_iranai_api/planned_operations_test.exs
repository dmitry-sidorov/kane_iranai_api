defmodule KaneIranaiApi.PlannedOperationsTest do
  use KaneIranaiApi.DataCase

  alias KaneIranaiApi.PlannedOperations

  describe "planned_operations" do
    alias KaneIranaiApi.PlannedOperations.PlannedOperation

    import KaneIranaiApi.PlannedOperationsFixtures

    @invalid_attrs %{status: nil, type: nil, amount: nil}

    test "list_planned_operations/0 returns all planned_operations" do
      planned_operation = planned_operation_fixture()
      assert PlannedOperations.list_planned_operations() == [planned_operation]
    end

    test "get_planned_operation!/1 returns the planned_operation with given id" do
      planned_operation = planned_operation_fixture()
      assert PlannedOperations.get_planned_operation!(planned_operation.id) == planned_operation
    end

    test "create_planned_operation/1 with valid data creates a planned_operation" do
      valid_attrs = %{status: :canceled, type: :increase, amount: 42}

      assert {:ok, %PlannedOperation{} = planned_operation} = PlannedOperations.create_planned_operation(valid_attrs)
      assert planned_operation.status == :canceled
      assert planned_operation.type == :increase
      assert planned_operation.amount == 42
    end

    test "create_planned_operation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PlannedOperations.create_planned_operation(@invalid_attrs)
    end

    test "update_planned_operation/2 with valid data updates the planned_operation" do
      planned_operation = planned_operation_fixture()
      update_attrs = %{status: :draft, type: :decrease, amount: 43}

      assert {:ok, %PlannedOperation{} = planned_operation} = PlannedOperations.update_planned_operation(planned_operation, update_attrs)
      assert planned_operation.status == :draft
      assert planned_operation.type == :decrease
      assert planned_operation.amount == 43
    end

    test "update_planned_operation/2 with invalid data returns error changeset" do
      planned_operation = planned_operation_fixture()
      assert {:error, %Ecto.Changeset{}} = PlannedOperations.update_planned_operation(planned_operation, @invalid_attrs)
      assert planned_operation == PlannedOperations.get_planned_operation!(planned_operation.id)
    end

    test "delete_planned_operation/1 deletes the planned_operation" do
      planned_operation = planned_operation_fixture()
      assert {:ok, %PlannedOperation{}} = PlannedOperations.delete_planned_operation(planned_operation)
      assert_raise Ecto.NoResultsError, fn -> PlannedOperations.get_planned_operation!(planned_operation.id) end
    end

    test "change_planned_operation/1 returns a planned_operation changeset" do
      planned_operation = planned_operation_fixture()
      assert %Ecto.Changeset{} = PlannedOperations.change_planned_operation(planned_operation)
    end
  end
end
