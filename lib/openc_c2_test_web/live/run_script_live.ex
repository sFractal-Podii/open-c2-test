defmodule OpencC2TestWeb.RunScriptLive do
  use Phoenix.LiveView

  import OpencC2TestWeb.CoreComponents
  alias OpencC2Test.TestScript

  def mount(_param, _session, socket) do
    # after calling the changeset call to_form
    {:ok, assign(socket, form: to_form(TestScript.change_script(%TestScript{})))}
  end

  def render(assigns) do
    ~H"""
    <.form for={@form} phx-change="validate" phx-submit="save">
      <.input
        type="select"
        field={@form[:device]}
        options={[TwinklyMaha: "twinklymaha"]}
        prompt="Select project"
        label="Which device are you testing?"
      />

      <.input
        type="select"
        field={@form[:broker]}
        options={[mosquito_test_broker: "mosquito"]}
        prompt="Select broker"
        label="Which broker do you want to use?"
      />

      <.input
        type="select"
        field={@form[:command]}
        options={[
          Turn_led_on: "turn_led_on",
          Turn_led_off: "turn_led_off",
          Query_profile: "query_profile",
          Query_sbom: "query_sbom"
        ]}
        prompt="Select command"
        label="What command do you want to send?"
      />
      <.button>Run</.button>
    </.form>
    """
  end

  def handle_event("validate", %{"test_script" => params}, socket) do
    form =
      %TestScript{}
      |> TestScript.change_script(params)
      |> to_form()

    {:noreply, assign(socket, form: form)}
  end

  def handle_event("save", %{"test_script" => params}, socket) do
    command = Path.expand("./test_script.sh")

    color =
      case params["command"] do
        "turn_led_on" -> "on"
        "turn_led_off" -> "off"
      end

    action =
      cond do
        params["command"] in ["turn_led_on", "turn_led_off"] -> "set"
        true -> "query"
      end

    args =
      '{"action": "#{action}", "target": {"x-sfractal-blinky:led": "#{color}"}, "args": {"response_requested": "complete"}}'
      |> Jason.decode!()
      |> Jason.encode!()

    System.cmd(command, [
      args
    ])

    {:noreply, socket}
  end
end
