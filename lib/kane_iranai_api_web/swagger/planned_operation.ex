defmodule KaneIranaiApiWeb.Swagger.PlannedOperation do
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
