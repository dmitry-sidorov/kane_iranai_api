defmodule KaneIranaiApi.OperationsLinksTest do
  use KaneIranaiApi.DataCase

  alias KaneIranaiApi.OperationsLinks

  describe "operations_links" do
    alias KaneIranaiApi.OperationsLinks.OperationsLink

    import KaneIranaiApi.OperationsLinksFixtures

    @invalid_attrs %{}

    test "list_operations_links/0 returns all operations_links" do
      operations_link = operations_link_fixture()
      assert OperationsLinks.list_operations_links() == [operations_link]
    end

    test "get_operations_link!/1 returns the operations_link with given id" do
      operations_link = operations_link_fixture()
      assert OperationsLinks.get_operations_link!(operations_link.id) == operations_link
    end

    test "create_operations_link/1 with valid data creates a operations_link" do
      valid_attrs = %{}

      assert {:ok, %OperationsLink{} = operations_link} = OperationsLinks.create_operations_link(valid_attrs)
    end

    test "create_operations_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = OperationsLinks.create_operations_link(@invalid_attrs)
    end

    test "update_operations_link/2 with valid data updates the operations_link" do
      operations_link = operations_link_fixture()
      update_attrs = %{}

      assert {:ok, %OperationsLink{} = operations_link} = OperationsLinks.update_operations_link(operations_link, update_attrs)
    end

    test "update_operations_link/2 with invalid data returns error changeset" do
      operations_link = operations_link_fixture()
      assert {:error, %Ecto.Changeset{}} = OperationsLinks.update_operations_link(operations_link, @invalid_attrs)
      assert operations_link == OperationsLinks.get_operations_link!(operations_link.id)
    end

    test "delete_operations_link/1 deletes the operations_link" do
      operations_link = operations_link_fixture()
      assert {:ok, %OperationsLink{}} = OperationsLinks.delete_operations_link(operations_link)
      assert_raise Ecto.NoResultsError, fn -> OperationsLinks.get_operations_link!(operations_link.id) end
    end

    test "change_operations_link/1 returns a operations_link changeset" do
      operations_link = operations_link_fixture()
      assert %Ecto.Changeset{} = OperationsLinks.change_operations_link(operations_link)
    end
  end
end
