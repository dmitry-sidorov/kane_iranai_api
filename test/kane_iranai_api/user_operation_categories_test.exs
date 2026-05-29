defmodule KaneIranaiApi.UserOperationCategoriesTest do
  use KaneIranaiApi.DataCase

  alias KaneIranaiApi.UserOperationCategories
  alias KaneIranaiApi.Users
  alias KaneIranaiApi.OperationCategories
  import KaneIranaiApi.UsersFixtures
  import KaneIranaiApi.OperationCategoriesFixtures

  describe "user_operation_categories" do
    def seed_entities do
      seed_users()
      seed_operation_categories()
    end

    setup do
      :ok = Ecto.Adapters.SQL.Sandbox.checkout(KaneIranaiApi.Repo)
    end

    test "should add operation category to user" do
      seed_entities()

      for num <- 0..2 do
        operation_category = OperationCategories.list_operation_categories() |> Enum.at(num)
        user = Users.list_users() |> Enum.at(num)
        UserOperationCategories.create_user_operation_category(user, operation_category)
        user_operation_categories = UserOperationCategories.list_user_operation_categories()

        assert user_operation_categories
               |> Enum.any?(fn %{user: %{id: user_id}, operation_category: %{id: operation_category_id}} ->
                 user_id == user.id and operation_category_id == operation_category.id
               end)
      end
    end

    test "should delete user's common operation categories without deleting common categories" do
      seed_entities()

      for num <- 0..2 do
        operation_category = OperationCategories.list_operation_categories() |> Enum.at(num)
        user = Users.list_users() |> Enum.at(num)
        UserOperationCategories.create_user_operation_category(user, operation_category)
      end

      user_operation_categories = UserOperationCategories.list_user_operation_categories()
      operation_categories = OperationCategories.list_operation_categories()

      assert user_operation_categories |> Enum.count() == 3
      assert operation_categories |> Enum.count() == 3

      for num <- 0..2 do
        user_operation_category = user_operation_categories |> Enum.at(num)
        user = Users.list_users() |> Enum.at(num)
        UserOperationCategories.delete_user_operation_category(user_operation_category, user)
      end

      assert UserOperationCategories.list_user_operation_categories() |> Enum.count() == 0
      assert OperationCategories.list_operation_categories() |> Enum.count() == 3
    end

    test "should delete user's operation categories with user's custom categories" do
      seed_entities()
      seed_private_operation_categories()

      for num <- 0..2 do
        operation_category = OperationCategories.list_operation_categories() |> Enum.at(num + 3)
        user = Users.list_users() |> Enum.at(num)
        UserOperationCategories.create_user_operation_category(user, operation_category)
      end

      user_operation_categories = UserOperationCategories.list_user_operation_categories()
      operation_categories = OperationCategories.list_operation_categories()

      assert user_operation_categories |> Enum.count() == 3
      assert operation_categories |> Enum.count() == 6

      for num <- 0..2 do
        user_operation_category = user_operation_categories |> Enum.at(num)
        user = Users.list_users() |> Enum.at(num)
        UserOperationCategories.delete_user_operation_category(user_operation_category, user)
      end

      assert UserOperationCategories.list_user_operation_categories() |> Enum.count() == 0
      assert OperationCategories.list_operation_categories() |> Enum.count() == 3
    end

    test "should return operation categories for given user" do
      seed_operation_categories()
      seed_users_with_categories()

      for num <- 0..2 do
        user = Users.list_users() |> Enum.at(num)
        user_with_categories = Users.get_user!(user.id)
        assert user_with_categories.operation_categories == OperationCategories.list_operation_categories()
      end
    end
  end
end
