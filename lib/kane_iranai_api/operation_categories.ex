defmodule KaneIranaiApi.OperationCategories do
  @moduledoc """
  The OperationCategories context.
  """

  import Ecto.Query, warn: false
  alias KaneIranaiApi.Repo

  alias KaneIranaiApi.OperationCategories.OperationCategory

  @doc """
  Returns the list of operation_categories.

  ## Examples

      iex> list_operation_categories()
      [%OperationCategory{}, ...]

  """
  def list_operation_categories do
    Repo.all(OperationCategory)
  end

  @doc """
  Gets a single operation_category.

  Raises `Ecto.NoResultsError` if the Operation category does not exist.

  ## Examples

      iex> get_operation_category!(123)
      %OperationCategory{}

      iex> get_operation_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_operation_category!(id), do: Repo.get!(OperationCategory, id)

  @doc """
  Creates a operation_category.

  ## Examples

      iex> create_operation_category(%{field: value})
      {:ok, %OperationCategory{}}

      iex> create_operation_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_operation_category(attrs) do
    %OperationCategory{}
    |> OperationCategory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a operation_category.

  ## Examples

      iex> update_operation_category(operation_category, %{field: new_value})
      {:ok, %OperationCategory{}}

      iex> update_operation_category(operation_category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_operation_category(%OperationCategory{} = operation_category, attrs) do
    operation_category
    |> OperationCategory.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a operation_category.

  ## Examples

      iex> delete_operation_category(operation_category)
      {:ok, %OperationCategory{}}

      iex> delete_operation_category(operation_category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_operation_category(%OperationCategory{} = operation_category) do
    Repo.delete(operation_category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking operation_category changes.

  ## Examples

      iex> change_operation_category(operation_category)
      %Ecto.Changeset{data: %OperationCategory{}}

  """
  def change_operation_category(%OperationCategory{} = operation_category, attrs \\ %{}) do
    OperationCategory.changeset(operation_category, attrs)
  end
end
