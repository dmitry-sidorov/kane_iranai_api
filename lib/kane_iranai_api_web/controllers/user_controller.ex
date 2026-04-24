defmodule KaneIranaiApiWeb.UserController do
  use KaneIranaiApiWeb, :controller

  alias KaneIranaiApi.Users
  alias KaneIranaiApi.Users.User
  alias KaneIranaiApiWeb.Auth.{ErrorResponse, Guardian}

  action_fallback KaneIranaiApiWeb.FallbackController
  plug :is_authorized_user when action in [:show, :update, :delete]

  defp is_authorized_user(conn, _opts) do
    IO.puts("is_authorized_user")
    %{params: %{"id" => id}} = conn

    user = Users.get_user!(id)

    cond do
      conn.assigns.user.id == user.id -> conn
      true -> raise ErrorResponse.Forbidden
    end
  end

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, :index, users: users)
  end

  def create(conn, %{"user" => user_params}) do
    user_params |> dbg()
    case Users.create_user(user_params) do
      {:ok, %User{} = user} -> authorize_user(conn, user.email, user_params["hash_password"])
      error -> error
    end
  end

  def sign_in(conn, %{"email" => email, "password" => password}) do
    authorize_user(conn, email, password)
  end

  defp authorize_user(conn, email, password) do
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
    |> render("user_token.json", %{user: user, token: nil})
  end


  def refresh_session(conn, %{}) do
    current_token = Guardian.Plug.current_token(conn)
    {:ok, user, token} = Guardian.authenticate(current_token)

    conn
    |> Plug.Conn.put_session(:user_id, user.id)
    |> put_status(:ok)
    |> render("user_token.json", %{user: user, token: token})
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, :show, user: user)
  end

  def update(conn, %{"user" => user_params}) do
    user = Users.get_user!(user_params["id"])

    with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
      render(conn, :show, user: user)
    end
  end

  def delete(conn, %{"user" => user_params}) do
    IO.puts("delete")
    user = Users.get_user!(user_params["id"])

    with {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
