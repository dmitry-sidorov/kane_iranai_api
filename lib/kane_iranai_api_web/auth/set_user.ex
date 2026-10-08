defmodule KaneIranaiApiWeb.Auth.SetUser do
  import Plug.Conn
  alias KaneIranaiApiWeb.Auth.ErrorResponse
  alias KaneIranaiApiWeb.Auth.Guardian

  def init(_opts), do: %{}

  def call(conn, _opts) do
    case Guardian.Plug.current_resource(conn) do
      nil -> raise ErrorResponse.Unathorized
      user -> assign(conn, :user, user)
    end
  end
end
