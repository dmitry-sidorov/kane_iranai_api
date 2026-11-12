defmodule KaneIranaiApiWeb.DefaultController do
  use KaneIranaiApiWeb, :controller
  use PhoenixSwagger

  swagger_path :index do
    summary "API status"
    description "Returns a plain-text status banner with the environment and version."
    tag "System"
    produces "text/plain"
    response 200, "Service is alive", %Schema{type: :string}
  end

  def index(conn, _params) do
    message = [
      "=============================",
      "|> Kane Iranai API is alive!",
      "-----------------------------",
      "|> Environment: #{Mix.env()}",
      "-----------------------------",
      "|> Version: #{Mix.Project.config()[:version]}",
      "=============================",
    ] |> Enum.join("\n")

    text(conn, message)
  end
end
