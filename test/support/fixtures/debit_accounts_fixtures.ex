defmodule KaneIranaiApi.DebitAccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `KaneIranaiApi.DebitAccounts` context.
  """

  @doc """
  Generate a debit_account.
  """
  def debit_account_fixture(attrs \\ %{}) do
    {:ok, debit_account} =
      attrs
      |> Enum.into(%{
        amount: 42,
        title: "some title",
        type: :card
      })
      |> KaneIranaiApi.DebitAccounts.create_debit_account()

    debit_account
  end
end
