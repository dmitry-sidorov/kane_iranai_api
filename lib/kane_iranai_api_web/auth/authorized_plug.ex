defmodule KaneIranaiApiWeb.Auth.AuthorizedPlug do
  @moduledoc """
  Plug to authorize user access to resources.
  """
  alias KaneIranaiApiWeb.Auth.ErrorResponse

  def authorized_user?(%{params: %{"id" => id}} = conn, _opts) do
    if conn.assigns.user.id == id do
      conn
    else
      raise ErrorResponse.Forbidden
    end
  end
end
