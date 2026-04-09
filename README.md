# KaneIranaiApi

To start your Phoenix server:

- Create database container `docker run --name kane_iranai_api_dev -p 5432:5432 -e POSTGRES_USER=kane_iranai_api -e POSTGRES_PASSWORD=kane_iranai_api -d postgres`
- Run `mix setup` to install and setup dependencies
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

API is available on [`localhost:5544/api`](http://localhost:5544/api) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).