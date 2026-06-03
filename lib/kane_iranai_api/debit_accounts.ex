defmodule KaneIranaiApi.DebitAccounts do
  @moduledoc """
  The DebitAccounts context.
  """

  import Ecto.Query, warn: false
  alias KaneIranaiApi.Repo

  alias KaneIranaiApi.DebitAccounts.DebitAccount
  alias KaneIranaiApi.Users.User
  alias KaneIranaiApi.Currencies.Currency

  @doc """
  Returns the list of debit_accounts.

  ## Examples

      iex> list_debit_accounts()
      [%DebitAccount{}, ...]

  """
  def list_debit_accounts do
    DebitAccount
    |> Repo.all()
    |> Repo.preload([:user, :currency])
  end

  @doc """
  Gets a single debit_account.

  Raises `Ecto.NoResultsError` if the Debit account does not exist.

  ## Examples

      iex> get_debit_account!(123)
      %DebitAccount{}

      iex> get_debit_account!(456)
      ** (Ecto.NoResultsError)

  """
  def get_debit_account!(id), do: Repo.get!(DebitAccount, id)

  @doc """
  Creates a debit_account.

  ## Examples

      iex> create_debit_account(user, currency, %{field: value})
      {:ok, %DebitAccount{}}

      iex> create_debit_account(user, currency, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_debit_account(%User{} = user, %Currency{} = currency, attrs) do
    # %DebitAccount{}
    # |> Repo.preload(:users)
    # |> Repo.preload(:currencies)
    # |> Ecto.Changeset.change()
    # |> Ecto.Changeset.put_assoc(:user, user)
    # |> Ecto.Changeset.put_assoc(:currency, currency)
    # |> DebitAccount.changeset(attrs)
    # |> Repo.insert()

    # %DebitAccount{}
    # |> Ecto.build_assoc(:user, user)
    # |> Ecto.Changeset.change()
    # |> Ecto.build_assoc(:currency, currency)
    # |> DebitAccount.changeset(attrs)
    # |> Repo.insert()

    %DebitAccount{user_id: user.id, currency_id: currency.id}
    |> DebitAccount.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a debit_account.

  ## Examples

      iex> update_debit_account(debit_account, %{field: new_value})
      {:ok, %DebitAccount{}}

      iex> update_debit_account(debit_account, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_debit_account(%DebitAccount{} = debit_account, attrs) do
    debit_account
    |> DebitAccount.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a debit_account.

  ## Examples

      iex> delete_debit_account(debit_account)
      {:ok, %DebitAccount{}}

      iex> delete_debit_account(debit_account)
      {:error, %Ecto.Changeset{}}

  """
  def delete_debit_account(%DebitAccount{} = debit_account) do
    Repo.delete(debit_account)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking debit_account changes.

  ## Examples

      iex> change_debit_account(debit_account)
      %Ecto.Changeset{data: %DebitAccount{}}

  """
  def change_debit_account(%DebitAccount{} = debit_account, attrs \\ %{}) do
    DebitAccount.changeset(debit_account, attrs)
  end
end
