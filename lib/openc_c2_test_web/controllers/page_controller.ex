defmodule OpencC2TestWeb.PageController do
  use OpencC2TestWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    github_auth_url = Routes.auth_path(OpencC2TestWeb.Endpoint, :request, "github")
    render(conn, :home, [layout: false, github_auth_url: github_auth_url])
  end
end
