defmodule KaneIranaiApi.BudgetPlans.BudgetPlan do
  use Ecto.Schema
  import Ecto.Changeset

  alias KaneIranaiApi.Users.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "budget_plans" do
    field :start_date, :naive_datetime
    field :period_in_days, :integer
    field :description, :string
    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(budget_plan, attrs) do
    budget_plan
    |> cast(attrs, [:start_date, :period_in_days, :description])
    |> validate_required([:start_date, :period_in_days, :description])
  end
end
