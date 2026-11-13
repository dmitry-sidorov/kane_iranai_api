defmodule KaneIranaiApiWeb.Swagger.BudgetPlan do
  @moduledoc """
  Swagger definition for BudgetPlan endpoints.
  """
  defmacro __using__(_opts) do
    quote do
      use PhoenixSwagger

      def swagger_definitions do
        %{
          BudgetPlan:
            swagger_schema do
              title("Budget plan")

              properties do
                id(:string, "Budget plan ID", format: :uuid, required: true)
                start_date(:string, "Start date", format: :date, required: true)
                period_in_days(:integer, "Period length in days", required: true)
                description(:string, "Description", required: true)

                planned_operations(
                  PhoenixSwagger.Schema.array(:PlannedOperation),
                  "Planned operations"
                )
              end
            end,
          BudgetPlanResponse:
            swagger_schema do
              title("Budget plan response")

              properties do
                budget_plan(PhoenixSwagger.Schema.ref(:BudgetPlan), "Budget plan", required: true)
              end
            end,
          BudgetPlanList:
            swagger_schema do
              title("Budget plan list")

              properties do
                budget_plans(PhoenixSwagger.Schema.array(:BudgetPlan), "Budget plans",
                  required: true
                )
              end
            end,
          BudgetPlanCreateRequest:
            swagger_schema do
              title("Create budget plan request")

              properties do
                start_date(:string, "Start date", format: :date, required: true)
                period_in_days(:integer, "Period length in days", required: true)
                description(:string, "Description", required: true)
              end
            end,
          BudgetPlanPayload:
            swagger_schema do
              title("Budget plan payload")

              properties do
                start_date(:string, "Start date", format: :date)
                period_in_days(:integer, "Period length in days")
                description(:string, "Description")
              end
            end,
          BudgetPlanUpdateRequest:
            swagger_schema do
              title("Update budget plan request")

              properties do
                id(:string, "Budget plan ID", format: :uuid, required: true)

                payload(PhoenixSwagger.Schema.ref(:BudgetPlanPayload), "Fields to update",
                  required: true
                )
              end
            end
        }
      end

      swagger_path :index do
        summary("List budget plans")
        description("Lists budget plans belonging to the authenticated user.")
        tag("Budget Plans")
        produces("application/json")
        security([%{Bearer: []}])
        response(200, "Budget plans", :BudgetPlanList)
        response(401, "Unauthorized", :AuthError)
      end

      swagger_path :show do
        summary("Show budget plan")
        tag("Budget Plans")
        produces("application/json")
        security([%{Bearer: []}])
        parameter(:id, :path, :string, "Budget plan ID", required: true, format: :uuid)
        response(200, "Budget plan", :BudgetPlanResponse)
        response(401, "Unauthorized", :AuthError)
        response(404, "Not found", :NotFoundError)
      end

      swagger_path :create do
        summary("Create budget plan")
        description("Creates a budget plan for the authenticated user.")
        tag("Budget Plans")
        consumes("application/json")
        produces("application/json")
        security([%{Bearer: []}])

        parameter(
          :body,
          :body,
          PhoenixSwagger.Schema.ref(:BudgetPlanCreateRequest),
          "Budget plan", required: true)

        response(201, "Created", :BudgetPlanResponse)
        response(401, "Unauthorized", :AuthError)
        response(422, "Validation error", :ChangesetError)
      end

      swagger_path :update do
        summary("Update budget plan")
        tag("Budget Plans")
        consumes("application/json")
        produces("application/json")
        security([%{Bearer: []}])

        parameter(
          :body,
          :body,
          PhoenixSwagger.Schema.ref(:BudgetPlanUpdateRequest),
          "Update payload", required: true)

        response(200, "Updated budget plan", :BudgetPlanResponse)
        response(401, "Unauthorized", :AuthError)
        response(404, "Not found", :NotFoundError)
      end

      swagger_path :delete do
        summary("Delete budget plan")
        tag("Budget Plans")
        security([%{Bearer: []}])
        parameter(:id, :query, :string, "Budget plan ID", required: true, format: :uuid)
        response(204, "Deleted")
        response(401, "Unauthorized", :AuthError)
        response(404, "Not found", :NotFoundError)
      end
    end
  end
end
