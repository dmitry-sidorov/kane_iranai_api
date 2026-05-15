defmodule KaneIranaiApi.OperationCategoriesAssets do
  @moduledoc """
  The OperationCategoriesAssets context.
  """

  import Ecto.Query, warn: false
  alias KaneIranaiApi.Repo

  alias KaneIranaiApi.OperationCategoriesAssets.OperationCategoryAsset
  alias KaneIranaiApi.Users.User
  alias KaneIranaiApi.OperationCategories.OperationCategory

  @doc """
  Returns the list of operation_categories_assets.

  ## Examples

      iex> list_operation_categories_assets()
      [%OperationCategoryAsset{}, ...]

  """
  def list_operation_categories_assets do
    OperationCategoryAsset
    |> Repo.all()
    |> Repo.preload([:user, :operation_category])
  end

  @doc """
  Gets a single operation_category_asset.

  Raises `Ecto.NoResultsError` if the Operation category asset does not exist.

  ## Examples

      iex> get_operation_category_asset!(123)
      %OperationCategoryAsset{}

      iex> get_operation_category_asset!(456)
      ** (Ecto.NoResultsError)

  """
  def get_operation_category_asset!(id), do: Repo.get!(OperationCategoryAsset, id)

  @doc """
  Creates an operation_category_asset and associates it with the given user and operation category.

  ## Examples

      iex> create_operation_category_asset(%{title: "Cash"}, user, operation_category)
      {:ok, %OperationCategoryAsset{}}

      iex> create_operation_category_asset(%{title: nil}, user, operation_category)
      {:error, %Ecto.Changeset{}}

  """
  def create_operation_category_asset(attrs, %User{} = user, %OperationCategory{} = operation_category) do
    %OperationCategoryAsset{}
    |> OperationCategoryAsset.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Ecto.Changeset.put_assoc(:operation_category, operation_category)
    |> Repo.insert()
  end

  @doc """
  Updates a operation_category_asset.

  ## Examples

      iex> update_operation_category_asset(operation_category_asset, %{field: new_value})
      {:ok, %OperationCategoryAsset{}}

      iex> update_operation_category_asset(operation_category_asset, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_operation_category_asset(%OperationCategoryAsset{} = operation_category_asset, attrs) do
    operation_category_asset
    |> OperationCategoryAsset.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a operation_category_asset.

  ## Examples

      iex> delete_operation_category_asset(operation_category_asset, user)
      {:ok, %OperationCategoryAsset{}}

      iex> delete_operation_category_asset(operation_category_asset,user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_operation_category_asset(%OperationCategoryAsset{} = operation_category_asset, %User{} = user) do
    {:ok, operation_category_asset} = Repo.delete(operation_category_asset)

    %OperationCategoryAsset{operation_category: operation_category} = operation_category_asset

    if user.id == operation_category_asset.user.id and operation_category.type == :private  do
      Repo.delete(operation_category)
    end

    {:ok, operation_category_asset}
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking operation_category_asset changes.

  ## Examples

      iex> change_operation_category_asset(operation_category_asset)
      %Ecto.Changeset{data: %OperationCategoryAsset{}}

  """
  def change_operation_category_asset(%OperationCategoryAsset{} = operation_category_asset, attrs \\ %{}) do
    OperationCategoryAsset.changeset(operation_category_asset, attrs)
  end
end
