defmodule KaneIranaiApi.UsersFixtures do
  alias KaneIranaiApi.Users.User
  require ExUnitProperties

  @moduledoc """
  This module defines test helpers for creating
  entities via the `KaneIranaiApi.Users` context.
  """
  def unique_email do
    domains = [
      "gmail.com",
      "hotmail.com",
      "yahoo.com",
    ]

    email_generator =
      ExUnitProperties.gen all name <- StreamData.string(:alphanumeric),
                              name != "",
                              domain <- StreamData.member_of(domains) do
        name <> "@" <> domain
      end

    [email] = Enum.take(StreamData.resize(email_generator, 20), 1)

    email
  end

  def unique_string do
    email_generator =
      ExUnitProperties.gen all name <- StreamData.string(:alphanumeric),
                              name != "" do
        name
      end

    StreamData.resize(email_generator, 20)
    |> Enum.at(1)
  end

  @doc """
  Generate mock user attrs.
  """
  def mock_user_attrs() do
    name = unique_string()

    %{
      email: unique_email(),
      first_name: name,
      hash_password: unique_string(),
      last_name: name,
      username: name,
    }
  end

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(mock_user_attrs())
      |> KaneIranaiApi.Users.create_user()

    user
  end

  def get_mock_users do
    Enum.map(1..3, fn _ -> struct(User, mock_user_attrs()) end)
  end
end
