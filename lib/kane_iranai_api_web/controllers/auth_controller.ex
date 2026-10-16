defmodule KaneIranaiApiWeb.AuthController do
  use KaneIranaiApiWeb, :controller

  alias KaneIranaiApiWeb.Auth.{ErrorResponse, Guardian}

  action_fallback KaneIranaiApiWeb.FallbackController

  def sign_in(conn, %{"email" => email, "password" => password}) do
    authorize_user(conn, email, password)
  end

  def authorize_user(conn, email, password) do
    case Guardian.authenticate(email, password) do
      {:ok, user, token} ->
        conn
        |> Plug.Conn.put_session(:user_id, user.id)
        |> put_status(:ok)
        |> render(:user_token, %{user: user, token: token})
      {:error, :unathorized} -> raise ErrorResponse.Unathorized, message: "Email or password incorrect!"
    end
  end

  def sign_out(conn, %{}) do
    user = conn.assigns[:user]
    token = Guardian.Plug.current_token(conn)
    Guardian.revoke(token)
    conn
    |> Plug.Conn.clear_session()
    |> put_status(:ok)
    |> render("auth_token.json", %{user: user, token: nil})
  end


  def refresh_session(conn, %{}) do
    current_token = Guardian.Plug.current_token(conn)
    {:ok, user, token} = Guardian.authenticate(current_token)

    conn
    |> Plug.Conn.put_session(:user_id, user.id)
    |> put_status(:ok)
    |> render("auth_token.json", %{user: user, token: token})
  end

  def current_user(conn, %{}) do
    conn
    |> put_status(:ok)
    |> render(:current_user, user: conn.assigns.user)
  end
end
