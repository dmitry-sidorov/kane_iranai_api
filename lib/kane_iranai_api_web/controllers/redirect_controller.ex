defmodule KaneIranaiApiWeb.RedirectController do
  use KaneIranaiApiWeb, :controller
  use KaneIranaiApiWeb.Swagger.Redirect

  def permanent_redirect(conn, _params) do
    redirect(conn, to: ~p"/api")
  end
end
