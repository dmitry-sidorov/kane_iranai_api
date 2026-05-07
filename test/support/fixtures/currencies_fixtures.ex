defmodule KaneIranaiApi.CurrenciesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `KaneIranaiApi.Currencies` context.
  """

  @doc """
  Generate a currency.
  """
  def currency_fixture(attrs \\ %{}) do
    {:ok, currency} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> KaneIranaiApi.Currencies.create_currency()

    currency
  end
end
