defmodule OpencC2TestWeb.SbomLive do
    # use Phoenix.LiveView
    use OpencC2TestWeb, :live_view


    def render(assigns) do
     assigns = sbom_files(assigns)

        ~H"""
        <p>SBOMs for this site are available in several formats and serializations.</p>
          <%= for {k, v} <- @sbom_files do %>
              <ol><%= k %></ol>
              <%= for file <- v do %>
                  <li><%= link(file, to: ["sbom/", file]) %></li>
              <% end %>
          <% end %>
        """
    end

    defp sbom_files(assigns) do
        files =
         :openc_c2_test
          |> Application.app_dir("/priv/static/.well-known/sbom")
          |> File.ls!()
    
        sbom_files =
          Enum.reduce(["cyclonedx", "spdx", "vex"], %{}, fn filter, acc ->
            Map.put(acc, filter, filter_files(files, filter))
          end)
        assign_new(assigns, :sbom_files, fn -> sbom_files end)
    end

    defp filter_files(files, filter) do
        regex = Regex.compile!(filter)
        files |> Enum.filter(fn file -> Regex.match?(regex, file) end)
      end
end