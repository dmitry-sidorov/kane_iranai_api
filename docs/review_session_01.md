# Analysis: `docs/spec.md` vs `docs/db_schema.dbml` (Session 01 - Claude Sonnet 5, High reasoning)

I cross-referenced every user-flow section in the spec against the DBML and also checked it against what's *actually implemented* in `lib/` and `priv/repo/migrations/` (which has already diverged from the DBML). Findings below, ordered by severity.

## 1. Bugs / inconsistencies in the current DBML

| # | Location | Issue |
|---|----------|-------|
| 1 | `Enum operation_type` (line 4) | `descrease` is misspelled — should be `decrease`. |
| 2 | `Enum operation_type` vs. Postgres enum name in code | **Naming collision waiting to happen.** `docs/db_schema.dbml` reserves the name `operation_type` for the *operations* increase/decrease enum, but `20260511195749_create_operation_categories.exs` already runs `create_type(:operation_type, [:public, :private])` for `operation_categories.type`. When the `operations` table is eventually migrated with its own `type` enum, the Postgres type name `operation_type` will already be taken. Rename one of them now (e.g. `operation_category_visibility`) before more migrations depend on the current name. |
| 3 | `transfer_operations.source_account_id` / `target_account_id` (lines 62–63) | Modeled as one-to-one (`ref: -`), but a debit account can obviously be the source/target of *many* transfers. Should be `ref: >` (many-to-one), same as every other FK in the file. |
| 4 | `operations.debit_account_id [not null]` (line 53) | Conflicts with the spec's account-deletion rule ("deleting an account should not remove associated transactions"). If the FK stays `not null` with default `on_delete: :nothing`, deleting a `debit_accounts` row will be blocked by referential integrity, not soft-preserved. You need either a soft-delete flag on `debit_accounts` (recommended) or `on_delete: :nilify_all` + nullable FK. |
| 5 | Money columns typed `float` (`operations.amount`, `debit_accounts.amount`, `transfer_operations.amount`, `planned_operations.amount`, `budget_plans`) | Floating point is unsafe for currency math (rounding errors compound in a finance app). Use `decimal`/`numeric`, or store integer minor units (cents) consistently. Note the **actual migration already contradicts the DBML**: `debit_accounts.amount` is `:integer` in code but `float` in the doc — pick one strategy and make the doc match reality. |
| 6 | Primary keys typed `integer` (line 26, 34, etc.) | The real implementation uses `:binary_id` (UUIDs) everywhere. The DBML is stale here and should be updated to `uuid` to avoid misleading future contributors. |
| 7 | `users.password` comment "Not hashed for MVP" (line 30) | Already false — `user.ex` hashes with `Bcrypt.hash_pwd_salt/1` and the column is `hash_password`. Update the doc. |
| 8 | `email email` type (line 27) | `email` isn't a real column type; use `varchar`/`string` with app-level/DB `unique` + format validation (already `[unique, not null]` is missing here too — add it). |

## 2. Spec requirements with **no** corresponding schema at all

### Groups — entirely missing
Spec section "Groups" (shared accounts, admin/member roles, invite/remove members, delete-and-reassign accounts) has zero representation in the DBML. Needed:

```dbml
Table groups {
  id uuid [primary key]
  name string [not null]
  description string
  owner_id uuid [not null, ref: > users.id]
  deleted_at timestamp
}

Table group_members {
  id uuid [primary key]
  group_id uuid [not null, ref: > groups.id]
  user_id uuid [not null, ref: > users.id]
  role group_member_role // admin | member
  status group_member_status // invited | accepted | removed
  invited_at timestamp
  joined_at timestamp

  indexes {
    (group_id, user_id) [unique]
  }
}
```
Plus a nullable `group_id` on `debit_accounts` (and on `budget_plans` per spec item "use budget plan in group with another users") to know which resources belong to which group. Group-scoped resources also imply an **authorization layer** — see architecture section below.

### Email confirmation / password reset — no persistence
Spec ("User should confirm email address", "reset password via email recovery link") needs token storage. Recommend the standard pattern (similar to `phx.gen.auth`) rather than ad-hoc columns on `users`:

```dbml
Table user_tokens {
  id uuid [primary key]
  user_id uuid [not null, ref: > users.id]
  token binary [not null]
  context string [not null] // "confirm", "reset_password", "session"
  sent_to string
  inserted_at timestamp
}
```

### Currency conversion (optional spec item) — no exchange rate table
If you implement it, you need somewhere to store fetched rates (and an audit trail for what rate was applied to a given operation, since rates change over time):

```dbml
Table exchange_rates {
  id uuid [primary key]
  base_currency_id uuid [ref: > currencies.id]
  quote_currency_id uuid [ref: > currencies.id]
  rate decimal [not null]
  fetched_at timestamp [not null]
}
```
And if operations can be recorded in a currency different from the account's currency, you should store the rate actually applied on the operation row itself (`applied_rate`, or `converted_amount`) — don't rely on re-deriving history from a rates table that mutates.

## 3. Spec requirements that are only *partially* modeled

**User Operation Categories** — spec says users assign categories *to their accounts* and can *reorder* them, but `user_operation_category` only joins `users` ↔ `operation_categories` (no `debit_account_id`), and has no ordering column. Either:
- add `debit_account_id` to the join table if categorization really is per-account, or
- reword the spec if it's actually per-user (applies across all accounts) — as currently designed, "assign categories to their accounts" and "categories associated with each account" aren't actually satisfiable.

Either way, add a `position integer` column to support "manage the order of categories."

**Operation Categories ownership** — `operation_categories.type` distinguishes `public`/`private`, and custom categories are attached to a user only via the join table. But spec requires "edit and delete **their** custom categories," which implies ownership, not just assignment (a user could otherwise edit/delete a private category assigned to them that was actually created by someone else in a shared group context). Add an explicit `owner_id uuid [ref: > users.id]` (nullable — null for system/public categories) to unambiguously answer "who may mutate this row."

**Transfer operations** — missing fields needed by the spec's own bullet points:
- `status` enum (`pending | completed | cancelled`) — required for "cancel pending transfers."
- `user_id` — to filter "their own" transfers and to know who to authorize.
- `currency_id` (and possibly `applied_rate`) if source/target accounts can differ in currency.
- `processed_at`/timestamps — required for "filter by date range."
- Consider whether a transfer should also write two `operations` rows (double-entry) for a unified transaction history/report, or stay a separate ledger. Right now `operations` and `transfer_operations` are disconnected, so "view account transaction history" (Account #2) won't naturally include transfers unless you union both tables or link them explicitly (`operation_id` on each leg).

**Budget plans** — spec's edit bullet mentions "title, amount, category, and duration," but the table has no `title` and no top-level `amount`/`category` (those live on `planned_operations` instead). Clarify whether a plan has its own overall budget amount+category, or whether that phrasing in the spec is loosely referring to child `planned_operations`. At minimum add a `title` column.

**Planned operations** — spec says they're "tracked against real operations in given dates," but there's no date field on `planned_operations` (it only inherits `budget_plans.date_start` + `period_in_days`), and no `description` (mentioned in the edit bullet). If tracking is at a finer granularity than the whole plan period (e.g. "planned $200 groceries for the first two weeks"), add `date_start`/`date_end` (or a single `due_date`) and `description`. The commented-out `operation_id` ref (line 91) suggests you considered a 1:1 link — but tracking "real operations against a plan" is inherently many-to-one (many operations count toward one planned line item), so a single FK on `planned_operations` is the wrong cardinality; if you want an explicit link rather than a category+date-range query, that requires a join table, not a column on `planned_operations`.

## 4. Indexes / constraints worth documenting in the DBML

None of the FK columns show indexes in the DBML (the real migrations do add several, which is good — keep the doc in sync). Also missing:
- `operations`: composite index on `(user_id, processed_at)` for the date-range filter use case, plus `(debit_account_id)`, `(operation_category_id)`.
- `transfer_operations`: indexes on `source_account_id`, `target_account_id`.
- Uniqueness constraint on `group_members (group_id, user_id)`.
- A DB check (or app validation) that `transfer_operations.source_account_id != target_account_id`.

## 5. Architecture-level suggestions

- **Missing Oban** — several spec items are inherently async/scheduled: budget-limit notifications ("receive notifications when limits are approached or exceeded"), exchange-rate refresh, email sending retries. There's no job-processing dependency in `mix.exs` yet; add `oban` rather than trying to do this synchronously or with ad-hoc `GenServer`s.
- **Authorization layer** — up to now every resource is single-owner (`user_id`), and there's no policy module. Once `groups` exist, admin/member roles and shared account/budget-plan access need a real authorization layer (e.g. `Bodyguard` or a hand-rolled `Policies` module) rather than sprinkling `if account.user_id == current_user.id` checks through controllers.
- **`Ecto.Multi` for compound writes** — a transfer that debits one account, credits another, and (if you go the double-entry route) inserts two `operations` rows should be one atomic `Ecto.Multi`/`Repo.transaction`, not three separate calls.
- **Reports context** — "generate reports showing budget utilization" is a read-model concern; a dedicated `KaneIranaiApi.Reports` context with pure query functions (rather than bolting aggregate queries onto `BudgetPlans`) will keep this maintainable, and if it gets slow at scale, materialized views or periodic Oban-computed snapshot tables are an option later.
- **Mailer wiring** — `swoosh` is already a dependency but confirmation/reset emails aren't implemented; this is the natural place to use it alongside the `user_tokens` table above.
- **Contexts not yet created**: `Operations`, `TransferOperations`, `BudgetPlans`, `PlannedOperations`, `Groups` don't exist under `lib/kane_iranai_api/` yet — only `Users`, `DebitAccounts`, `Currencies`, `OperationCategories`, `UserOperationCategories` are implemented. Worth sequencing work so `Groups` lands *before* `BudgetPlans`/`DebitAccounts` need group-scoping, since retrofitting a `group_id` FK onto tables that already have production data/policies is more disruptive than designing it in from the start.

## Suggested priority order
1. Fix the `operation_type` Postgres enum name collision now (cheapest to fix before more migrations build on it) and the `descrease` typo.
2. Decide the money-storage strategy (`decimal` vs. integer minor units) and align DBML + migrations + schema.
3. Design `groups`/`group_members` before wiring `budget_plans`/`debit_accounts` group-sharing (spec explicitly needs both).
4. Add `user_tokens` for confirmation/reset flows.
5. Add soft-delete (`deleted_at`) to `debit_accounts` (and probably `operation_categories`, `budget_plans`) to satisfy the "keep historical operations after account deletion" rule instead of relying on FK `on_delete` alone.
6. Flesh out `transfer_operations` (`status`, `user_id`, timestamps) to support "cancel pending transfers" and filtering.
7. Resolve the per-user vs. per-account ambiguity in `user_operation_category` and add the `position` column.