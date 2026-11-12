defmodule KaneIranaiApiWeb.Swagger.OperationCategory do
  defmacro __using__(_opts) do
    quote do
      use PhoenixSwagger

      def swagger_definitions do
        %{
          OperationCategory:
            swagger_schema do
              title("Operation category")

              properties do
                id(:string, "Operation category ID", format: :uuid, required: true)
                title(:string, "Title", required: true)
                description(:string, "Description")
              end
            end,
          OperationCategoryList:
            swagger_schema do
              title("Operation category list")

              properties do
                operation_categories(
                  PhoenixSwagger.Schema.array(:OperationCategory),
                  "Categories linked to the current user", required: true)
              end
            end
        }
      end

      swagger_path :index do
        summary("List operation categories")
        description("Lists operation categories linked to the authenticated user.")
        tag("Operation Categories")
        produces("application/json")
        security([%{Bearer: []}])
        response(200, "Operation categories", :OperationCategoryList)
        response(401, "Unauthorized", :AuthError)
      end
    end
  end
end
