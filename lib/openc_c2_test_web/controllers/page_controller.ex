defmodule OpencC2TestWeb.PageController do
  use OpencC2TestWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    # render(conn, :home, layout: false)
    oauth_github_url = ElixirAuthGithub.login_url(%{scopes: ["user:email"]})
    render(conn, :home, [layout: false, oauth_github_url: oauth_github_url])
  end
end
