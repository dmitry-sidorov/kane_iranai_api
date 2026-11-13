defmodule KaneIranaiApiWeb.Swagger.Default do
  @moduledoc """
  Swagger definition for Default endpoints.
  """
  defmacro __using__(_opts) do
    quote do
      use PhoenixSwagger

      swagger_path :index do
        summary("API status")
        description("Returns a plain-text status banner with the environment and version.")
        tag("System")
        produces("text/plain")
        response(200, "Service is alive", %PhoenixSwagger.Schema{type: :string})
      end
    end
  end
end
