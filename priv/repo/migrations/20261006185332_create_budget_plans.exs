defmodule KaneIranaiApi.Repo.Migrations.CreateBudgetPlans do
  use Ecto.Migration

  def change do
    create table(:budget_plans, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :start_date, :naive_datetime
      add :period_in_days, :integer
      add :description, :string
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:budget_plans, [:user_id])
  end
end
