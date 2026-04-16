defmodule KaneIranaiApiWeb.Auth.SetUser do
  import Plug.Conn
  alias KaneIranaiApiWeb.Auth.ErrorResponse
  alias KaneIranaiApi.Users

  def init(_opts) do

  end

  def call(conn, _opts) do
    unless conn.assigns[:account] do
      user_id = get_session(conn, :user_id)

      if user_id == nil, do: raise ErrorResponse.Unathorized

      try do
        user = Users.get_user!(user_id)
        assign(conn, :user, user)
      rescue
        _e -> raise ErrorResponse.Unathorized
      end
    else
      conn
    end
  end
end
