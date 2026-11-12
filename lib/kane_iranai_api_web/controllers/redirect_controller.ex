defmodule KaneIranaiApiWeb.RedirectController do
  use KaneIranaiApiWeb, :controller
  use PhoenixSwagger

  swagger_path :permanent_redirect do
    summary "Redirect to the API root"
    description "Redirects / to /api."
    tag "System"
    response 302, "Redirect to /api"
  end

  def permanent_redirect(conn, _params) do
    redirect(conn, to: ~p"/api")
  end
end
