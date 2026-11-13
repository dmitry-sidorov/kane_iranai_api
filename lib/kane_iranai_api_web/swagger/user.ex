defmodule KaneIranaiApiWeb.Swagger.User do
  @moduledoc """
  Swagger definition for User endpoints.
  """
  defmacro __using__(_opts) do
    quote do
      use PhoenixSwagger

      def swagger_definitions do
        %{
          User:
            swagger_schema do
              title("User")

              properties do
                id(:string, "User ID", format: :uuid, required: true)
                email(:string, "Email", format: :email, required: true)
                hash_password(:string, "Stored password hash")
                username(:string, "Username", required: true)
                first_name(:string, "First name")
                last_name(:string, "Last name")
              end
            end,
          UserResponse:
            swagger_schema do
              title("User response")

              properties do
                data(PhoenixSwagger.Schema.ref(:User), "User", required: true)
              end
            end,
          UserParams:
            swagger_schema do
              title("User params")

              properties do
                email(:string, "Email", format: :email, required: true)

                hash_password(:string, "Plain password. It is hashed before storage.",
                  required: true
                )

                username(:string, "Username", required: true)
                first_name(:string, "First name")
                last_name(:string, "Last name")
              end
            end,
          UserCreateRequest:
            swagger_schema do
              title("Create user request")

              properties do
                user(PhoenixSwagger.Schema.ref(:UserParams), "User attributes", required: true)
              end
            end,
          UserUpdateParams:
            swagger_schema do
              title("User update params")

              properties do
                email(:string, "Email", format: :email)
                hash_password(:string, "New plain password")
                username(:string, "Username")
                first_name(:string, "First name")
                last_name(:string, "Last name")
              end
            end,
          UserUpdateRequest:
            swagger_schema do
              title("Update user request")

              properties do
                current_password(:string, "Current password", required: true)

                user(PhoenixSwagger.Schema.ref(:UserUpdateParams), "Fields to update",
                  required: true
                )
              end
            end,
          UserDeleteParams:
            swagger_schema do
              title("User delete params")

              properties do
                id(:string, "User ID", format: :uuid, required: true)
              end
            end,
          UserDeleteRequest:
            swagger_schema do
              title("Delete user request")

              properties do
                user(PhoenixSwagger.Schema.ref(:UserDeleteParams), "User to delete",
                  required: true
                )
              end
            end
        }
      end

      swagger_path :create do
        summary("Create user")
        description("Creates a user with default categories and returns an access token.")
        tag("Users")
        consumes("application/json")
        produces("application/json")

        parameter(
          :body,
          :body,
          PhoenixSwagger.Schema.ref(:UserCreateRequest),
          "User registration payload", required: true)

        response(200, "Created and authenticated", :AuthToken)
        response(401, "Unauthorized", :ErrorMessage)
        response(422, "Validation error", :ChangesetError)
      end

      swagger_path :show do
        summary("Show user")
        description("Returns the user. The authenticated user can only read their own record.")
        tag("Users")
        produces("application/json")
        security([%{Bearer: []}])
        parameter(:id, :path, :string, "User ID", required: true, format: :uuid)
        response(200, "User", :UserResponse)
        response(401, "Unauthorized", :AuthError)
        response(403, "Forbidden", :ErrorMessage)
        response(404, "Not found", :NotFoundError)
      end

      swagger_path :update do
        summary("Update user")
        description("Updates the authenticated user. Requires the current password.")
        tag("Users")
        consumes("application/json")
        produces("application/json")
        security([%{Bearer: []}])

        parameter(:body, :body, PhoenixSwagger.Schema.ref(:UserUpdateRequest), "Update payload",
          required: true
        )

        response(200, "Updated user", :UserResponse)
        response(401, "Unauthorized or password incorrect", :ErrorMessage)
      end

      swagger_path :delete do
        summary("Delete user")
        description("Deletes the user identified in the request body.")
        tag("Users")
        consumes("application/json")
        security([%{Bearer: []}])

        parameter(:body, :body, PhoenixSwagger.Schema.ref(:UserDeleteRequest), "Delete payload",
          required: true
        )

        response(204, "Deleted")
        response(401, "Unauthorized", :AuthError)
        response(404, "Not found", :NotFoundError)
      end
    end
  end
end
