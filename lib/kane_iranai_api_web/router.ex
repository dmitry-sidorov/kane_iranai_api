defmodule KaneIranaiApiWeb.Router do
  use KaneIranaiApiWeb, :router
  use PhoenixSwagger

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", KaneIranaiApiWeb do
    pipe_through :api
    get "/" , RedirectController, :permanent_redirect
  end

  scope "/api", KaneIranaiApiWeb do
    pipe_through :api
    get "/" , DefaultController, :index
    post "/users/create", UserController, :create
  end

  scope "/api/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI, otp_app: :kane_iranai_api, swagger_file: "swagger.json"
  end

  def swagger_info do
    %{
      info: %{
        version: "#{Mix.Project.config()[:version]}",
        title: "Kane Iranai API"
      }
    }
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:kane_iranai_api, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: KaneIranaiApiWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
