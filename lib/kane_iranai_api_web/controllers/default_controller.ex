defmodule KaneIranaiApiWeb.DefaultController do
  use KaneIranaiApiWeb, :controller

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
