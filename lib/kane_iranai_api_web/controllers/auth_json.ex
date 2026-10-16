defmodule KaneIranaiApiWeb.AuthJSON do
  def current_user(%{user: user}) do
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
