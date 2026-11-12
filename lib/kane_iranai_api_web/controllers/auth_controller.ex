defmodule KaneIranaiApiWeb.AuthController do
  use KaneIranaiApiWeb, :controller
  use PhoenixSwagger

  alias KaneIranaiApiWeb.Auth.{ErrorResponse, Guardian}

  action_fallback KaneIranaiApiWeb.FallbackController

  def swagger_definitions do
    %{
      AuthToken: swagger_schema do
        title "Auth token"
        properties do
          id :string, "User ID", format: :uuid, required: true
          email :string, "Email", format: :email, required: true
          token :string, "Access token. Null after logout."
        end
      end,
      CurrentUser: swagger_schema do
        title "Current user"
        properties do
          id :string, "User ID", format: :uuid, required: true
          email :string, "Email", format: :email, required: true
          username :string, "Username", required: true
          first_name :string, "First name"
          last_name :string, "Last name"
        end
      end,
      LoginRequest: swagger_schema do
        title "Login request"
        properties do
          email :string, "Email", format: :email, required: true
          password :string, "Password", required: true
        end
      end,
      AuthError: swagger_schema do
        title "Authentication error"
        properties do
          error :string, "Guardian error type", required: true
        end
      end,
      ErrorMessage: swagger_schema do
        title "Error message"
        properties do
          errors :string, "Error message", required: true
        end
      end,
      NotFoundError: swagger_schema do
        title "Not found"
        properties do
          ecto_error :string, "Entity not found", required: true
        end
      end,
      ChangesetError: swagger_schema do
        title "Changeset error"
        properties do
          errors :object, "Field errors", required: true
        end
      end
    }
  end

  swagger_path :sign_in do
    summary "Sign in"
    description "Authenticates by email and password and returns an access token."
    tag "Auth"
    consumes "application/json"
    produces "application/json"
    parameter :body, :body, Schema.ref(:LoginRequest), "Credentials", required: true
    response 200, "Authenticated", :AuthToken
    response 401, "Email or password incorrect", :ErrorMessage
  end

  swagger_path :current_user do
    summary "Current user"
    description "Returns the user loaded from the access token."
    tag "Auth"
    produces "application/json"
    security [%{Bearer: []}]
    response 200, "Current user", :CurrentUser
    response 401, "Unauthorized", :AuthError
  end

  swagger_path :refresh_session do
    summary "Refresh session"
    description "Revokes the current access token and returns a new one."
    tag "Auth"
    produces "application/json"
    security [%{Bearer: []}]
    response 200, "Refreshed token", :AuthToken
    response 401, "Unauthorized", :AuthError
    response 404, "Token subject not found", :ErrorMessage
  end

  swagger_path :sign_out do
    summary "Sign out"
    description "Revokes the current access token and clears the session."
    tag "Auth"
    produces "application/json"
    security [%{Bearer: []}]
    response 200, "Signed out. Token is null.", :AuthToken
    response 401, "Unauthorized", :AuthError
  end

  def sign_in(conn, %{"email" => email, "password" => password}) do
    authorize_user(conn, email, password)
  end

  def authorize_user(conn, email, password) do
    case Guardian.authenticate(email, password) do
      {:ok, user, token} ->
        conn
        |> Plug.Conn.put_session(:user_id, user.id)
        |> put_status(:ok)
        |> render(:auth_token, %{user: user, token: token})
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
