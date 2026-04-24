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
    with {:ok, %User{} = user} <- Users.create_user(user_params),
          {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render(:user_token, %{user: user, token: token})
    end
  end

  def sign_in(conn, %{"email" => email, "password" => password}) do
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
    old_token = Guardian.Plug.current_token(conn)

    with {:ok, claims} <- Guardian.decode_and_verify(old_token),
          {:ok, user} <- Guardian.resource_from_claims(claims) do
            {:ok, _old, {new_token, _new_claims}} = Guardian.refresh(old_token)
            conn
            |> Plug.Conn.put_session(:user_id, user.id)
            |> put_status(:ok)
            |> render("user_token.json", %{user: user, token: new_token})
    else
      {:error, _reason} -> raise ErrorResponse.NotFound
    end
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
