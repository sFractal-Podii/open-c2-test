defmodule OpencC2TestWeb.AuthController do
  @moduledoc """
  Auth controller responsible for handling Ueberauth responses
  """

  use OpencC2TestWeb, :controller

  def index(conn, %{"code" => code}) do
    {:ok, profile} = ElixirAuthGithub.github_auth(code)

    conn
    |> put_view(OpencC2TestWeb.PageHTML)
    |> render(:welcome, profile: profile)
  end
end
