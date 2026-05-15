defmodule KaneIranaiApi.UsersFixtures do
  alias KaneIranaiApi.Users.User

  @moduledoc """
  This module defines test helpers for creating
  entities via the `KaneIranaiApi.Users` context.
  """

  @doc """
  Generate a unique user email.
  """
  def unique_user_email, do: "some email#{System.unique_integer([:positive])}"

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: unique_user_email(),
        first_name: "some first_name",
        hash_password: "some hash_password",
        last_name: "some last_name",
        username: "some username"
      })
      |> KaneIranaiApi.Users.create_user()

    user
  end

  def get_mock_users do
    [
      %User{first_name: "Jose", last_name: "Valim", username: "jose_valim", email: "jose_valim@gmail.com", hash_password: "test_user_1"},
      %User{first_name: "Steve", last_name: "McConnel", username: "steve_macconel", email: "steve@gmail.com", hash_password: "test_user_2"},
      %User{first_name: "Joe", last_name: "Armstrong", username: "joe_armstrong", email: "joe_armstrong@gmail.com", hash_password: "test_user_3"}
    ]
  end
end
