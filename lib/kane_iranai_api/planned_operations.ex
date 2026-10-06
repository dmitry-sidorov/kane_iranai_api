defmodule KaneIranaiApi.PlannedOperations do
  @moduledoc """
  The PlannedOperations context.
  """

  import Ecto.Query, warn: false
  alias KaneIranaiApi.Repo

  alias KaneIranaiApi.PlannedOperations.PlannedOperation

  @doc """
  Returns the list of planned_operations.

  ## Examples

      iex> list_planned_operations()
      [%PlannedOperation{}, ...]

  """
  def list_planned_operations do
    Repo.all(PlannedOperation)
  end

  @doc """
  Gets a single planned_operation.

  Raises `Ecto.NoResultsError` if the Planned operation does not exist.

  ## Examples

      iex> get_planned_operation!(123)
      %PlannedOperation{}

      iex> get_planned_operation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_planned_operation!(id), do: Repo.get!(PlannedOperation, id)

  @doc """
  Creates a planned_operation.

  ## Examples

      iex> create_planned_operation(%{field: value})
      {:ok, %PlannedOperation{}}

      iex> create_planned_operation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_planned_operation(attrs) do
    %PlannedOperation{}
    |> PlannedOperation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a planned_operation.

  ## Examples

      iex> update_planned_operation(planned_operation, %{field: new_value})
      {:ok, %PlannedOperation{}}

      iex> update_planned_operation(planned_operation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_planned_operation(%PlannedOperation{} = planned_operation, attrs) do
    planned_operation
    |> PlannedOperation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a planned_operation.

  ## Examples

      iex> delete_planned_operation(planned_operation)
      {:ok, %PlannedOperation{}}

      iex> delete_planned_operation(planned_operation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_planned_operation(%PlannedOperation{} = planned_operation) do
    Repo.delete(planned_operation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking planned_operation changes.

  ## Examples

      iex> change_planned_operation(planned_operation)
      %Ecto.Changeset{data: %PlannedOperation{}}

  """
  def change_planned_operation(%PlannedOperation{} = planned_operation, attrs \\ %{}) do
    PlannedOperation.changeset(planned_operation, attrs)
  end
end
