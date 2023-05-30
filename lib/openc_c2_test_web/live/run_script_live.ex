defmodule OpencC2TestWeb.RunScriptLive do
  use Phoenix.LiveView

  import OpencC2TestWeb.CoreComponents

  def mount(_param, _session, socket) do
    # after calling the changeset call to_form
    {:ok, assign(socket, form: to_form(%{}, as: :inputs))}
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
        field={@form[:device]}
        options={[mosquito_test_broker: "mosquito"]}
        prompt="Select broker"
        label="Which broker do you want to use?"
      />

      <.input
        type="select"
        field={@form[:device]}
        options={[
          Turn_led_on: "turn_led_on",
          Turn_led_off: "turn_led_off",
          Query_profile: "query_profile",
          Query_sbom: "query_sbom"
        ]}
        prompt="Select command"
        label="What command do you want to send?"
      />
      <button>Run</button>
    </.form>
    """
  end

  def handle_event("validate", %{"inputs" => params}, socket) do
    IO.inspect(params, label: "++++++++++++++++++++++++++")
    #    form =
    #   %User{}
    #   |> Accounts.change_user(params)
    #   |> Map.put(:action, :insert)
    #   |> to_form()

    # {:noreply, assign(socket, form: form)}
    {:noreply, socket}
  end

  def handle_event("save", %{"user" => params}, socket) do
    # case Accounts.create_user(user_params) do
    #   {:ok, user} ->
    #     {:noreply,
    #      socket
    #      |> put_flash(:info, "user created")
    #      |> redirect(to: ~p"/users/#{user}")}

    #   {:error, %Ecto.Changeset{} = changeset} ->
    #     {:noreply, assign(socket, form: to_form(changeset))}
    # end
    {:noreply, socket}
  end
end
