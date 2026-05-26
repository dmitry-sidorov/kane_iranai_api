defmodule KaneIranaiApi.UserOperationCategories do
  @moduledoc """
  The UserOperationCategories context.
  """

  import Ecto.Query, warn: false
  alias KaneIranaiApi.OperationCategories
  alias KaneIranaiApi.Repo

  alias KaneIranaiApi.UserOperationCategories.UserOperationCategory
  alias KaneIranaiApi.Users.User
  alias KaneIranaiApi.OperationCategories.OperationCategory

  @doc """
  Returns the list of user_operation_categories.

  ## Examples

      iex> list_user_operation_categories()
      [%UserOperationCategory{}, ...]

  """
  def list_user_operation_categories do
    UserOperationCategory
    |> Repo.all()
    |> Repo.preload([:user, :operation_category])
  end

  @doc """
  Gets a single user_operation_category.

  Raises `Ecto.NoResultsError` if the User operation category does not exist.

  ## Examples

      iex> get_user_operation_category!(123)
      %UserOperationCategory{}

      iex> get_user_operation_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_operation_category!(id), do: Repo.get!(UserOperationCategory, id)

  @doc """
  Creates a user_operation_category and associates it with the given user and operation category.

  ## Examples

      iex> create_user_operation_category(%{title: "Cash"}, user, operation_category)
      {:ok, %UserOperationCategory{}}

      iex> create_user_operation_category(%{title: nil}, user, operation_category)
      {:error, %Ecto.Changeset{}}

  """
  def create_user_operation_category(attrs, %User{} = user, %OperationCategory{} = operation_category) do
    %UserOperationCategory{}
    |> UserOperationCategory.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Ecto.Changeset.put_assoc(:operation_category, operation_category)
    |> Repo.insert()
  end

  @doc """
  Creates public user_operation_categories and associates them with the given user and public operation categories.

  ## Examples

      iex> create_public_user_operation_categories(user)
      {:ok, [%UserOperationCategory{}]}

      iex> create_public_user_operation_categories(user)
      {:error, %Ecto.Changeset{}}

  """
  def create_public_user_operation_categories(%User{} = user) do
    public_operation_categories =
      OperationCategories.list_operation_categories()
      |> Enum.filter(fn operation_category -> operation_category.type == "public" end)

    result =
      public_operation_categories
      |> Enum.reduce(fn operation_category, result ->
        {:ok, created_user_operation_category} =
          create_user_operation_category(%{title: nil}, user, operation_category)

        [created_user_operation_category | result]
      end, [])

    {:ok, Enum.reverse(result)}
  end

  @doc """
  Updates a user_operation_category.

  ## Examples

      iex> update_user_operation_category(user_operation_category, %{field: new_value})
      {:ok, %UserOperationCategory{}}

      iex> update_user_operation_category(user_operation_category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_operation_category(%UserOperationCategory{} = user_operation_category, attrs) do
    user_operation_category
    |> UserOperationCategory.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_operation_category.

  ## Examples

      iex> delete_user_operation_category(user_operation_category, user)
      {:ok, %UserOperationCategory{}}

      iex> delete_user_operation_category(user_operation_category, user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_operation_category(%UserOperationCategory{} = user_operation_category, %User{} = user) do
    {:ok, user_operation_category} = Repo.delete(user_operation_category)

    %UserOperationCategory{operation_category: operation_category} = user_operation_category

    if user.id == user_operation_category.user.id and operation_category.type == :private do
      Repo.delete(operation_category)
    end

    {:ok, user_operation_category}
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_operation_category changes.

  ## Examples

      iex> change_user_operation_category(user_operation_category)
      %Ecto.Changeset{data: %UserOperationCategory{}}

  """
  def change_user_operation_category(%UserOperationCategory{} = user_operation_category, attrs \\ %{}) do
    UserOperationCategory.changeset(user_operation_category, attrs)
  end
end
