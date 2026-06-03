defmodule KaneIranaiApi.Currencies.Currency do
  use Ecto.Schema
  import Ecto.Changeset

  alias KaneIranaiApi.DebitAccounts.DebitAccount

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "currencies" do
    field :title, :string
    has_many :debit_accounts, DebitAccount

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(currency, attrs) do
    currency
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
