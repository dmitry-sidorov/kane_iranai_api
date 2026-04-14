defmodule KaneIranaiApiWeb.Auth.ErrorResponse.Unathorized do
  defexception [message: "Unathorized", plug_status: 401]
end
