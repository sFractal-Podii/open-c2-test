defmodule OpencC2TestWeb.PageController do
  use OpencC2TestWeb, :controller
  import Phoenix.LiveView.Controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    github_auth_url = Routes.auth_path(OpencC2TestWeb.Endpoint, :request, "github")
    render(conn, :home, layout: false, github_auth_url: github_auth_url)
  end

  def sbom(conn, _params) do
    live_render(conn, OpencC2TestWeb.SbomLive)
  end
  
end
