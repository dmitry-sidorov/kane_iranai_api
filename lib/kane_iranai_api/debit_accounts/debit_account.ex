defmodule KaneIranaiApi.DebitAccounts.DebitAccount do
  use Ecto.Schema
  import Ecto.Changeset
  alias KaneIranaiApi.Currencies.Currency
  alias KaneIranaiApi.Users.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "debit_accounts" do
    field :title, :string
    field :amount, :integer
    field :type, Ecto.Enum, values: [:card, :cash, :deposit, :saving, :other]
    belongs_to :currency, Currency
    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(debit_account, attrs) do
    debit_account
    |> cast(attrs, [:title, :amount, :type])
    |> validate_required([:title, :amount, :type])
  end
end
