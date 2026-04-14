defmodule KaneIranaiApiWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :kane_iranai_api,
  module: KaneIranaiApiWeb.Auth.Guardian,
  error_handler: KaneIranaiApiWeb.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
