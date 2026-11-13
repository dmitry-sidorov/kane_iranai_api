defmodule KaneIranaiApiWeb.Swagger.Auth do
  @moduledoc """
  Swagger definition for Auth endpoints.
  """
  defmacro __using__(_opts) do
    quote do
      use PhoenixSwagger

      def swagger_definitions do
        %{
          AuthToken:
            swagger_schema do
              title("Auth token")

              properties do
                id(:string, "User ID", format: :uuid, required: true)
                email(:string, "Email", format: :email, required: true)
                token(:string, "Access token. Null after logout.")
              end
            end,
          CurrentUser:
            swagger_schema do
              title("Current user")

              properties do
                id(:string, "User ID", format: :uuid, required: true)
                email(:string, "Email", format: :email, required: true)
                username(:string, "Username", required: true)
                first_name(:string, "First name")
                last_name(:string, "Last name")
              end
            end,
          LoginRequest:
            swagger_schema do
              title("Login request")

              properties do
                email(:string, "Email", format: :email, required: true)
                password(:string, "Password", required: true)
              end
            end,
          AuthError:
            swagger_schema do
              title("Authentication error")

              properties do
                error(:string, "Guardian error type", required: true)
              end
            end,
          ErrorMessage:
            swagger_schema do
              title("Error message")

              properties do
                errors(:string, "Error message", required: true)
              end
            end,
          NotFoundError:
            swagger_schema do
              title("Not found")

              properties do
                ecto_error(:string, "Entity not found", required: true)
              end
            end,
          ChangesetError:
            swagger_schema do
              title("Changeset error")

              properties do
                errors(:object, "Field errors", required: true)
              end
            end
        }
      end

      swagger_path :sign_in do
        summary("Sign in")
        description("Authenticates by email and password and returns an access token.")
        tag("Auth")
        consumes("application/json")
        produces("application/json")

        parameter(:body, :body, PhoenixSwagger.Schema.ref(:LoginRequest), "Credentials",
          required: true
        )

        response(200, "Authenticated", :AuthToken)
        response(401, "Email or password incorrect", :ErrorMessage)
      end

      swagger_path :current_user do
        summary("Current user")
        description("Returns the user loaded from the access token.")
        tag("Auth")
        produces("application/json")
        security([%{Bearer: []}])
        response(200, "Current user", :CurrentUser)
        response(401, "Unauthorized", :AuthError)
      end

      swagger_path :refresh_session do
        summary("Refresh session")
        description("Revokes the current access token and returns a new one.")
        tag("Auth")
        produces("application/json")
        security([%{Bearer: []}])
        response(200, "Refreshed token", :AuthToken)
        response(401, "Unauthorized", :AuthError)
        response(404, "Token subject not found", :ErrorMessage)
      end

      swagger_path :sign_out do
        summary("Sign out")
        description("Revokes the current access token and clears the session.")
        tag("Auth")
        produces("application/json")
        security([%{Bearer: []}])
        response(200, "Signed out. Token is null.", :AuthToken)
        response(401, "Unauthorized", :AuthError)
      end
    end
  end
end
