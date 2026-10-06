defmodule KaneIranaiApi.DebitAccounts.DebitAccount do
  use Ecto.Schema
  import Ecto.Changeset
  alias KaneIranaiApi.Currencies.Currency
  alias KaneIranaiApi.Users.User
  alias KaneIranaiApi.Operations.Operation

  @debit_account_type_enum [:card, :cash, :deposit, :saving, :other]
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "debit_accounts" do
    field :title, :string
    field :amount, :integer
    field :type, Ecto.Enum, values: @debit_account_type_enum
    belongs_to :currency, Currency
    belongs_to :user, User
    has_many :operations, Operation

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(debit_account, attrs) do
    debit_account
    |> cast(attrs, [:title, :amount, :type])
    |> validate_required([:title, :amount, :type])
  end

  @doc false
  def get_field_enum(:type), do: @debit_account_type_enum
end
