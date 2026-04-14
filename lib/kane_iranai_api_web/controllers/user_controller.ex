defmodule KaneIranaiApiWeb.UserController do
  use KaneIranaiApiWeb, :controller

  alias KaneIranaiApi.Users
  alias KaneIranaiApi.Users.User
  alias KaneIranaiApiWeb.Auth.{ErrorResponse, Guardian}

  action_fallback KaneIranaiApiWeb.FallbackController

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
      {:ok, user, token} -> conn |> put_status(:ok) |> render(:user_token, %{user: user, token: token})
      {:error, :unathorized} -> raise ErrorResponse.Unathorized, message: "Email or password incorrect!"
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, :show, user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
      render(conn, :show, user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    with {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
