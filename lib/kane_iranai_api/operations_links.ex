defmodule KaneIranaiApi.OperationsLinks do
  @moduledoc """
  The OperationsLinks context.
  """

  import Ecto.Query, warn: false
  alias KaneIranaiApi.Repo

  alias KaneIranaiApi.OperationsLinks.OperationsLink

  @doc """
  Returns the list of operations_links.

  ## Examples

      iex> list_operations_links()
      [%OperationsLink{}, ...]

  """
  def list_operations_links do
    Repo.all(OperationsLink)
  end

  @doc """
  Gets a single operations_link.

  Raises `Ecto.NoResultsError` if the Operations link does not exist.

  ## Examples

      iex> get_operations_link!(123)
      %OperationsLink{}

      iex> get_operations_link!(456)
      ** (Ecto.NoResultsError)

  """
  def get_operations_link!(id), do: Repo.get!(OperationsLink, id)

  @doc """
  Creates a operations_link.

  ## Examples

      iex> create_operations_link(%{field: value})
      {:ok, %OperationsLink{}}

      iex> create_operations_link(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_operations_link(attrs) do
    %OperationsLink{}
    |> OperationsLink.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a operations_link.

  ## Examples

      iex> update_operations_link(operations_link, %{field: new_value})
      {:ok, %OperationsLink{}}

      iex> update_operations_link(operations_link, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_operations_link(%OperationsLink{} = operations_link, attrs) do
    operations_link
    |> OperationsLink.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a operations_link.

  ## Examples

      iex> delete_operations_link(operations_link)
      {:ok, %OperationsLink{}}

      iex> delete_operations_link(operations_link)
      {:error, %Ecto.Changeset{}}

  """
  def delete_operations_link(%OperationsLink{} = operations_link) do
    Repo.delete(operations_link)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking operations_link changes.

  ## Examples

      iex> change_operations_link(operations_link)
      %Ecto.Changeset{data: %OperationsLink{}}

  """
  def change_operations_link(%OperationsLink{} = operations_link, attrs \\ %{}) do
    OperationsLink.changeset(operations_link, attrs)
  end
end
