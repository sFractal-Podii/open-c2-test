defmodule OpencC2Test.UserFromAuth do
  @moduledoc """
  Retrieve the user information from an auth request
  """
  alias OpencC2Test.Accounts.User
  alias OpencC2Test.Accounts
  alias Ueberauth.Auth

  def find_or_create_user(%Auth{} = auth) do
    case Accounts.get_user(auth.info.email) do
      nil ->
        Accounts.create_user(%User{}, basic_info(auth))

      user ->
        {:ok, user}
    end
  end

  defp basic_info(auth) do
    %{
      uid: auth.uid,
      provider: Atom.to_string(auth.provider),
      email: auth.info.email,
      token: auth.credentials.token
    }
  end
end
