defmodule KaneIranaiApiWeb.Auth.AuthorizedPlug do
  alias KaneIranaiApiWeb.Auth.ErrorResponse

  def is_authorized_user(%{params: %{"id" => id}} = conn, _opts) do
    cond do
      conn.assigns.user.id == id -> conn
      true -> raise ErrorResponse.Forbidden
    end
  end
end
