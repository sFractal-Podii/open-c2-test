defmodule OpencC2TestWeb.AuthController do
  @moduledoc """
  Auth controller responsible for handling Ueberauth responses
  """
  use OpencC2TestWeb, :controller

  plug Ueberauth

  alias OpencC2Test.Accounts.User
  alias OpencC2Test.Repo

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user_data = %{token: auth.credentials.token, email: auth.info.email, provider: "github"}
    case find_or_create_user(user_data) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Successfully authenticated")
        |> put_session(:user_id, user.id)
        |> put_view(OpencC2TestWeb.PageHTML)
        |> render(:welcome, email: auth.info.email)

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Something went wrong")
        |> redirect(to: "/")
    end
  end

  defp find_or_create_user(user_data) do
    changeset = User.changeset(%User{}, user_data)
    case Repo.get_by(User, email: changeset.changes.email) do
      nil ->
        IO.puts("User not found, creating new")
        Repo.insert(changeset)
      user -> {:ok, user}
    end
  end
end
