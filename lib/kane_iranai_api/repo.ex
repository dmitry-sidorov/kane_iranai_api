defmodule KaneIranaiApi.Repo do
  use Ecto.Repo,
    otp_app: :kane_iranai_api,
    adapter: Ecto.Adapters.Postgres
end
