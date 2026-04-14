defmodule KaneIranaiApiWeb.UserJSON do
  alias KaneIranaiApi.Users.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      email: user.email,
      hash_password: user.hash_password,
      username: user.username,
      first_name: user.first_name,
      last_name: user.last_name
    }
  end

  def user_token(%{user: user, token: token}) do
    %{
      id: user.id,
      email: user.email,
      token: token
    }
  end
end
