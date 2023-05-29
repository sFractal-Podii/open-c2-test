defmodule OpencC2TestWeb.RunScriptLive do
  use Phoenix.LiveView

  def mount(_param, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <.form for={@form} phx-change="validate" phx-submit="save">
      <. label(@form, :name, "Name") />
      <.input type="text" field={@form[:username]} />
      <.input type="email" field={@form[:email]} />
      <button>Save</button>
    </.form>
    """
  end
end
