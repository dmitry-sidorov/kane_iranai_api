defmodule KaneIranaiApiWeb.OperationCategoryController do
  use KaneIranaiApiWeb, :controller
  use KaneIranaiApiWeb.Swagger.OperationCategory

  alias KaneIranaiApi.UserOperationCategories

  action_fallback KaneIranaiApiWeb.FallbackController

  def index(conn, _params) do
    user = conn.assigns.user

    user_operation_categories =
      UserOperationCategories.list_user_operation_categories_by_user(user)

    conn
    |> put_status(:ok)
    |> render(:index, operation_categories: user_operation_categories)
  end
end
