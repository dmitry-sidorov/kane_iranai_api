defmodule KaneIranaiApiWeb.Swagger.Redirect do
  defmacro __using__(_opts) do
    quote do
      use PhoenixSwagger

      swagger_path :permanent_redirect do
        summary("Redirect to the API root")
        description("Redirects / to /api.")
        tag("System")
        response(302, "Redirect to /api")
      end
    end
  end
end
