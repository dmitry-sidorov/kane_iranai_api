defmodule KaneIranaiApi.OperationCategoriesAssetsTest do
  use KaneIranaiApi.DataCase

  alias KaneIranaiApi.OperationCategoriesAssets

  describe "operation_categories_assets" do
    alias KaneIranaiApi.OperationCategoriesAssets.OperationCategoryAsset
    alias KaneIranaiApi.Users.User
    alias KaneIranaiApi.Users
    alias KaneIranaiApi.OperationCategories.OperationCategory
    alias KaneIranaiApi.OperationCategories

    @users [
      %User{first_name: "Jose", last_name: "Valim", username: "jose_valim", email: "jose_valim@gmail.com", hash_password: "test_user_1"},
      %User{first_name: "Steve", last_name: "McConnel", username: "steve_macconel", email: "steve@gmail.com", hash_password: "test_user_2"},
      %User{first_name: "Joe", last_name: "Armstrong", username: "joe_armstrong", email: "joe_armstrong@gmail.com", hash_password: "test_user_3"}
    ]

    @operation_categories [
      %OperationCategory{title: "Groceries", purpose: "secondary", type: "public" },
      %OperationCategory{title: "Restaurant", purpose: "secondary", type: "public" },
      %OperationCategory{title: "Car", purpose: "secondary", type: "public" },
    ]

    def seed_entities do
      seed_users()
      seed_operation_categories()
    end

    defp seed_users do
      for user <- @users do
        user
        |> Map.from_struct()
        |> Users.create_user()
      end
    end

    defp seed_operation_categories do
      for operation_category <- @operation_categories do
        operation_category
        |> Map.from_struct()
        |> OperationCategories.create_operation_category()
      end
    end

    setup do
      :ok = Ecto.Adapters.SQL.Sandbox.checkout(KaneIranaiApi.Repo)
      seed_entities()
    end

    for num <- 0..1 do
      @tag num: num
      test "should add operation category to user # #{num} asset", %{num: num} do
        operation_category = OperationCategories.list_operation_categories() |> Enum.at(num)
        user = Users.list_users() |> Enum.at(num)
        OperationCategoriesAssets.create_operation_category_asset(%{"title" => "my asset #{num}"}, user, operation_category)
        operation_categories_assets = OperationCategoriesAssets.list_operation_categories_assets()

        assert operation_categories_assets
              |> Enum.any?(fn %{user: %{id: user_id}, operation_category: %{id: operation_category_id}} ->
                user_id == user.id and operation_category_id == operation_category.id
              end)
      end
    end
  end
end
