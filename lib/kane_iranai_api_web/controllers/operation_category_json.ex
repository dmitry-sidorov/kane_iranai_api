defmodule KaneIranaiApiWeb.OperationCategoryJSON do
  alias KaneIranaiApi.UserOperationCategories.UserOperationCategory

  @doc """
  Renders a list of operation categories.
  """
  def index(%{operation_categories: operation_categories}) do
    %{operation_categories: for(category <- operation_categories, do: data(category))}
  end

  defp data(%UserOperationCategory{} = user_operation_category) do
    %{
      id: user_operation_category.operation_category.id,
      title: user_operation_category.operation_category.title,
      description: user_operation_category.operation_category.description,
    }
  end
end
