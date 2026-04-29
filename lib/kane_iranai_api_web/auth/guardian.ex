defmodule KaneIranaiApiWeb.Auth.Guardian do
  use Guardian, otp_app: :kane_iranai_api
  alias KaneIranaiApi.Users
  alias KaneIranaiApiWeb.Auth.ErrorResponse

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _claims) do
    {:error, :no_id_provided}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Users.get_user!(id) do
      nil -> {:error, :not_found}
      resource -> {:ok, resource}
    end
  end

  def resource_from_claims(_claims) do
    {:error, :no_id_provided}
  end

  def authenticate(email, password) do
    case Users.get_user_by_email(email) do
      nil -> {:error, :unathorized}
      user -> create_token(user, password, :access)
    end
  end

  def authenticate(token) do
    with {:ok, claims} <- decode_and_verify(token),
          {:ok, user} <- resource_from_claims(claims),
          {:ok, _old, {new_token, _new_claims}} <- refresh(token) do
            {:ok, user, new_token}
    else
      {:error, _reason} -> raise ErrorResponse.NotFound
    end
  end

  def validate_password(user, raw_password) do
    Bcrypt.verify_pass(raw_password, user.hash_password)
  end

  defp create_token(user, password, type) do
    case validate_password(user, password) do
      true -> with {:ok, token, _claims} <- encode_and_sign(user, %{}, token_options(type)), do: {:ok, user, token}
      false -> {:error, :unathorized}
    end
  end

  defp token_options(type) do
    case type do
      :access -> [token_type: "access", ttl: {2, :hour}]
      :reset -> [token_type: "reset", ttl: {15, :minute}]
      :admin -> [token_type: "admin", ttl: {90, :day}]
    end
  end

  def after_encode_and_sign(resource, claims, token, _options) do
    with {:ok, _} <- Guardian.DB.after_encode_and_sign(resource, claims["typ"], claims, token) do
      {:ok, token}
    end
  end

  def on_verify(claims, token, _options) do
    with {:ok, _} <- Guardian.DB.on_verify(claims, token) do
      {:ok, claims}
    end
  end

  def on_refresh({old_token, old_claims}, {new_token, new_claims}, _options) do
    with {:ok, _, _} <- Guardian.DB.on_refresh({old_token, old_claims}, {new_token, new_claims}) do
      {:ok, {old_token, old_claims}, {new_token, new_claims}}
    end
  end

  def on_revoke(claims, token, _options) do
    with {:ok, _} <- Guardian.DB.on_revoke(claims, token) do
      {:ok, claims}
    end
  end
end
