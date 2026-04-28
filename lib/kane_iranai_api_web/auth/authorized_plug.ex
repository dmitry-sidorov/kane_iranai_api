defmodule KaneIranaiApiWeb.Auth.AuthorizedPlug do
  alias KaneIranaiApiWeb.Auth.ErrorResponse
  alias KaneIranaiApi.Users

  def is_authorized_user(conn, _opts) do
    IO.puts("is_authorized_user")
    %{params: %{"id" => id}} = conn

    user = Users.get_user!(id)

    cond do
      conn.assigns.user.id == user.id -> conn
      true -> raise ErrorResponse.Forbidden
    end
  end
end
