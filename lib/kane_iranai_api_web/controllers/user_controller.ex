defmodule KaneIranaiApiWeb.UserController do
  use KaneIranaiApiWeb, :controller
  import KaneIranaiApiWeb.Auth.AuthorizedPlug

  alias KaneIranaiApi.Users
  alias KaneIranaiApiWeb.AuthController
  alias KaneIranaiApi.Users.User
  alias KaneIranaiApiWeb.Auth.{ErrorResponse, Guardian}

  action_fallback KaneIranaiApiWeb.FallbackController
  plug :is_authorized_user when action in [:show, :update, :delete]

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, :index, users: users)
  end

  def create(conn, %{"user" => user_params}) do
    case Users.create_user(user_params, :with_categories) do
      {:ok, %User{} = user} -> AuthController.authorize_user(conn, user.email, user_params["hash_password"])
      error -> error
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, :show, user: user)
  end

  # TODO: fix update endpoint
  def update(conn, %{"current_password" => current_password, "user" => user_params}) do
    case Guardian.validate_password(conn.assigns.user, current_password) do
      true ->
        {:ok, %User{} = user} = Users.update_user(conn.assigns.user, user_params)
        render(conn, :show, user: user)
      false -> raise ErrorResponse.Unathorized, message: "Password incorrect"
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
