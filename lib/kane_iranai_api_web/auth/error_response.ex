defmodule KaneIranaiApiWeb.Auth.ErrorResponse.Unathorized do
  defexception [message: "Unathorized", plug_status: 401]
end

defmodule KaneIranaiApiWeb.Auth.ErrorResponse.Forbidden do
  defexception [message: "You do not have access to this resource.", plug_status: 403]
end

defmodule KaneIranaiApiWeb.Auth.ErrorResponse.NotFound do
  defexception [message: "Not found.", plug_status: 404]
end
