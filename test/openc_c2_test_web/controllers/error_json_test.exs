defmodule OpencC2TestWeb.ErrorJSONTest do
  use OpencC2TestWeb.ConnCase, async: true

  test "renders 404" do
    assert OpencC2TestWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert OpencC2TestWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
