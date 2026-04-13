defmodule KaneIranaiApiWeb.RedirectController do
  use KaneIranaiApiWeb, :controller

  def permanent_redirect(conn, _params) do
    redirect(conn, to: ~p"/api")
  end
end
