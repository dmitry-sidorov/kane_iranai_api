defmodule KaneIranaiApiWeb.Swagger.PlannedOperation do
  @moduledoc """
  Swagger definition for PlannedOperation endpoints.
  """
  defmacro __using__(_opts) do
    quote do
      use PhoenixSwagger

      def swagger_definitions do
        %{
          PlannedOperation:
            swagger_schema do
              title("Planned operation")

              properties do
                id(:string, "Planned operation ID", format: :uuid, required: true)
                amount(:integer, "Amount", required: true)

                status(:string, "Status",
                  required: true,
                  enum: ["canceled", "draft", "pending", "resolved"]
                )

                type(:string, "Type", required: true, enum: ["increase", "decrease"])
                budget_plan_id(:string, "Budget plan ID", format: :uuid, required: true)

                operation_category_id(:string, "Operation category ID",
                  format: :uuid,
                  required: true
                )
              end
            end,
          PlannedOperationList:
            swagger_schema do
              title("Planned operation list")

              properties do
                planned_operations(PhoenixSwagger.Schema.array(:PlannedOperation), "Planned operations",
                  required: true
                )
              end
            end,
          PlannedOperationResponse:
            swagger_schema do
              title("Planned operation response")

              properties do
                planned_operation(
                  PhoenixSwagger.Schema.ref(:PlannedOperation),
                  "Planned operation", required: true)
              end
            end,
          PlannedOperationCreateRequest:
            swagger_schema do
              title("Create planned operation request")

              properties do
                budget_plan_id(:string, "Budget plan ID. Must belong to the current user.",
                  format: :uuid,
                  required: true
                )

                operation_category_id(
                  :string,
                  "Operation category ID. Must belong to the current user.",
                  format: :uuid,
                  required: true
                )

                amount(:integer, "Amount", required: true)

                status(:string, "Status",
                  required: true,
                  enum: ["canceled", "draft", "pending", "resolved"]
                )

                type(:string, "Type", required: true, enum: ["increase", "decrease"])
              end
            end
        }
      end

      swagger_path :index do
        summary("List planned operations")
        description("Lists planned operations belonging to given budget plan and the authenticated user.")
        tag("Planned Operations")
        produces("application/json")
        security([%{Bearer: []}])
        parameter(:budget_plan_id, :path, :string, "Budget plan ID", required: true, format: :uuid)
        response(200, "Planned operations", :PlannedOperationList)
        response(401, "Unauthorized", :AuthError)
        response(404, "Budget plan not found", :NotFoundError)
      end

      swagger_path :create do
        summary("Create planned operation")

        description(
          "Creates a planned operation when the budget plan and operation category belong to the authenticated user."
        )

        tag("Planned Operations")
        consumes("application/json")
        produces("application/json")
        security([%{Bearer: []}])

        parameter(
          :body,
          :body,
          PhoenixSwagger.Schema.ref(:PlannedOperationCreateRequest),
          "Planned operation", required: true)

        response(201, "Created", :PlannedOperationResponse)
        response(401, "Unauthorized", :AuthError)
        response(404, "Budget plan or operation category not found", :NotFoundError)
      end
    end
  end
end
