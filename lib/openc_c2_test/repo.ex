defmodule OpencC2Test.Repo do
  use Ecto.Repo,
    otp_app: :openc_c2_test,
    adapter: Ecto.Adapters.Postgres
end
